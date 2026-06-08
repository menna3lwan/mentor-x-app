# Feature Report — F-NM-2 Pending Account Status

**Status:** ✅ Implemented end-to-end (Mock + Dio + UI + Routing + i18n)
**Date:** 2026-06-08
**Type:** Auth gating + status polling

---

## 1. Scope

After a parent registers, the backend places the account in `pending` review.
This feature gates the entire app behind a dedicated `PendingAccountPage`
until the back-office approves the account, at which point the user is
automatically promoted into the main shell — no app restart required.

It also handles the rejected / suspended sub-state, surfacing the rejection
reason and a support contact instead of generic "something went wrong" copy.

## 2. Deliverables (Clean Architecture)

### Domain (`packages/mentorx_core`)

- `ParentAccountStatusEntity` — snapshot DTO with `status`, `rejectionReason`,
  `message`, `submittedAt`, `estimatedReviewBy`, `supportContact`, plus
  `isPending` / `isActive` / `isRejectedOrSuspended` getters and a
  `placeholder` constant.
- `ParentAccountStatusRepository` — abstract interface declaring
  `initialize()`, `getStatus()`, and `refreshAuthenticatedUser()`.
- `ParentAccountStatusRepositoryException` + `…ExceptionCode` enum
  (`unknown`, `fetchError`, `unauthorized`, `networkError`).

### Data — Dio (`packages/parent/dio_parent_account_status_repository`)

- `DioParentAccountStatusRepository`:
  - `GET /api/auth/pending-status` (primary).
  - Falls back to `GET /api/auth/me` on 404/405 so older backend builds work.
  - Defensive JSON parser supporting both camelCase and snake_case keys
    (`status`, `accountStatus`, `pending_status`, …).
  - Classifies 401/403 as `unauthorized` for the cubit to bubble up.

### Data — Mock (`packages/mock/parent/mock_parent_account_status_repository`)

- `MockParentAccountStatusRepository`:
  - First poll returns `pending`.
  - After `autoApproveAfter` (default 30s) elapses, automatically flips to
    `active` so dev/QA can observe the promotion transition.
  - `setStatus(...)` dev hook for tests to nudge the state directly.

### DI (`parent/lib/app/initializers/repositories_factory.dart`)

- Added `accountStatusRepository` field to `AppRepositories._`.
- Added `_initAccountStatusRepository()` factory honouring
  `Env.accountStatusRepositoryMode` (`prod` → Dio, `mock` → Mock).
- Wired into `Future.wait([...])` and exposed via `RepositoryProvider`.
- Added to `toList()` so the global "any in prod" / "fully mocked" guards
  cover the new repo.

### Env / config

- `Env.accountStatusRepositoryMode` (defaults to `prod`).
- `.env.example` → `ACCOUNT_STATUS_REPOSITORY_MODE=prod`.
- `.env.mock` → `ACCOUNT_STATUS_REPOSITORY_MODE=mock`.

### Presentation (`parent/lib/features/account_status`)

- `AccountStatusCubit` extends `Cubit` with `BlocPresentationMixin` —
  fires three presentation events:
  - `AccountStatusApprovedPresentationEvent` (transition pending → active).
  - `AccountStatusLoadFailedPresentationEvent` (manual refresh failure).
  - `AccountStatusUnauthorizedPresentationEvent` (401 → router logout).
- Polls every 30s while the page is mounted (`_pollInterval`), skips
  overlapping requests, cancels timer on `close()`.
- Detects pending → active by comparing previous vs. fresh entity and
  calls `_appAuthCubit.update(refreshedUser)` so the router redirect
  re-evaluates and pushes the user to `/home`.

- `PendingAccountPageWrapper` — provides the cubit and listens to
  presentation events.
- `_PendingAccountView` body composed of:
  - `_HeroCard` — hero badge + headline + subtitle + submitted/ETA
    metadata. Switches colour palette between `brandPrimary` (pending) and
    `statusDanger` (rejected/suspended).
  - `_StepsCard` — three-step vertical timeline (Received → Review →
    Approved) with active/completed dot states.
  - `_RejectionReasonCard` — only when `rejectionReason != null` and
    status is rejected/suspended.
  - `_SupportCard` — contact button (mailto: / tel:) using
    `url_launcher`.
  - `_ActionsRow` — primary "Check again" `MentorXButton` + secondary
    "Sign out" with confirmation dialog.
- All states covered: `initial`/`loading` (three skeletons), `failure`
  (`AppErrorView` with retry), `loaded` (full body).
- `PopScope(canPop: false)` prevents the system back gesture from
  escaping the gate.
- `RefreshIndicator` + AppBar refresh icon for manual polls.

### Routing (`parent/lib/core/routing/`)

- New `PendingAccountRoute` (`/pending-account`) + generated mixin in
  `.g.dart` (manually mirrored to avoid running `build_runner`).
- `AppRouter._onRedirect`:
  - Authenticated + status pending → bounce to `/pending-account`.
  - Authenticated + status active landing on `/pending-account` →
    bounce to `/home`.
  - Login / register / onboarding redirects respect the pending state
    (pending users go to `/pending-account`, others to `/home`).

### Localization (`packages/mentorx_ui/lib/localization`)

Added `parent.pendingAccount.*` namespace to:
- `sources/strings.json` (EN) + `sources/strings.i18n.json` + `sources/en.json`
- `sources/strings_ar.json` (AR) + `sources/strings_ar.i18n.json` + `sources/ar.json`
- `generated/strings_en.g.dart` (new `TranslationsParentPendingAccountEn` class)
- `generated/strings_ar.g.dart` (new `_TranslationsParentPendingAccountAr`)

Keys cover: page title, headlines, subtitles, status badges, submission
dates, rejection reason title, refresh actions, support copy, sign-out
flow, approval toast, error states, and the three timeline steps.

## 3. State / Flow Matrix

| Status | UI state | Polling | Actions available |
|---|---|---|---|
| `pending` (loading) | 3 skeletons | first request in flight | none |
| `pending` (loaded) | hero (blue) + steps + support | every 30s + manual | check again, sign out, contact |
| `pending` (refresh failed) | last-known body + error toast | continues | check again, sign out |
| `active` (transition) | brief, then auto-route | timer cancelled | n/a |
| `inactive` / `suspended` | hero (red) + reason + support | every 30s + manual | check again, sign out, contact |
| `loaded` but initial load failed entirely | `AppErrorView` | n/a | retry |
| 401 from backend | logout + `/login` | n/a | n/a |

## 4. Tests / Verification

- Manual review of cubit logic for double-emit guards (`isClosed` /
  `isRefreshing`), polling cancellation on `close()`, and presentation
  event ordering.
- Mock auto-promotion behaviour designed for QA: `flutter run
  --dart-define-from-file=parent/.env.mock` puts the app into the gate;
  the page transitions to home after 30s automatically.
- Router redirect logic preserves prior auth gating semantics — only
  adds two new branches (pending → gate; active landing on gate → home).

## 5. Known Limitations / Tech Debt

- Polling cadence (30s) is hard-coded; could be made env-driven.
- Backend may not expose `/api/auth/pending-status` in current EduCore
  build; Dio impl already falls back to `/api/auth/me` so this is safe.
- No deep-link handling: a magic email/SMS link that completes activation
  out-of-band still requires the user to be in the app (or kill + relaunch)
  to see the promotion. Acceptable for v1.
- Rejection/suspension path is rendered but the backend has no documented
  way to *re-submit* yet — the page currently exits via "Sign out" only.
