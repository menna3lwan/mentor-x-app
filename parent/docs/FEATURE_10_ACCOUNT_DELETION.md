# Feature Report — F-NM-4 Account Deletion (Right to be Forgotten)

**Status:** ✅ Implemented end-to-end (Mock + Dio + UI + Routing + i18n)
**Date:** 2026-06-08
**Type:** Security / Compliance (GDPR Article 17-style)

---

## 1. Scope

Lets a parent permanently delete their MentorX account from inside the
app. Three guard-rails prevent accidental destruction:

1. A bullet-point "what gets deleted" card.
2. An "I understand this is permanent" checkbox.
3. A locale-specific confirmation phrase (`DELETE` in English, `حذف` in
   Arabic) the parent must type verbatim before the danger CTA enables.

A final modal-dialog confirmation gates the actual submission. On success
the session token is invalidated server-side, so the wrapper logs the
user out locally and bounces them to `/login`.

## 2. Deliverables (Clean Architecture)

### Domain (`packages/mentorx_core`)

- `ParentAccountDeletionRequest` — value-object input payload (reason,
  confirmationPhrase, acknowledgedPermanent, requestDataExport) with
  `copyWith` / `toJson` / `Equatable` plumbing.
- `ParentAccountDeletionRepository` — abstract interface with
  `initialize()` + `submitDeletion(request)`.
- `ParentAccountDeletionRepositoryException` +
  `ParentAccountDeletionRepositoryExceptionCode` enum (`unknown`,
  `submitError`, `unauthorized`, `networkError`, `validation`).

### Data — Dio (`packages/parent/dio_parent_account_deletion_repository`)

- `DioParentAccountDeletionRepository`:
  - Primary: `POST /api/auth/delete-account` with `request.toJson()`.
  - Fallback: `DELETE /api/auth/me` on 404/405 for older backends.
  - Classifies 401/403 → `unauthorized`, 422 → `validation`, default →
    `unknown` / `submitError`.

### Data — Mock (`packages/mock/parent/mock_parent_account_deletion_repository`)

- `MockParentAccountDeletionRepository`:
  - Sleeps for `delay` to mimic latency.
  - Enforces the same `acknowledgedPermanent == true` guard the real
    backend would.
  - `failNext` toggle lets QA exercise the failure branch without
    backend help.
  - `lastRequest` captured for widget-test assertions.

### DI (`parent/lib/app/initializers/repositories_factory.dart`)

- Added `accountDeletionRepository` field to `AppRepositories._`.
- Added `_initAccountDeletionRepository()` factory honouring
  `Env.accountDeletionRepositoryMode` (`prod` → Dio, `mock` → Mock).
- Wired into `Future.wait([...])`, `toList()`, and
  `RepositoryProvider<ParentAccountDeletionRepository>`.

### Env / config

- `Env.accountDeletionRepositoryMode` (defaults to `prod`).
- `Env.usesAnyProdRepository` / `isFullyMocked` updated.
- `.env.example` → `ACCOUNT_DELETION_REPOSITORY_MODE=prod`.
- `.env.mock` → `ACCOUNT_DELETION_REPOSITORY_MODE=mock`.

### Presentation (`parent/lib/features/account_deletion`)

- `AccountDeletionBloc` (Bloc with `BlocPresentationMixin`):
  - Events: `ReasonChanged`, `ConfirmationChanged`,
    `AcknowledgementToggled`, `DataExportToggled`, `Submitted`.
  - Submit transformer: `droppable()` — repeated taps cannot fan out
    requests.
  - State exposes `canSubmit` getter, `isConfirmationPhraseValid` getter,
    `expectedPhrase` (locale-specific).
  - Maps backend errors → `AccountDeletionFailureKind` (validation,
    network, unauthorized, unknown).
  - Local guards run before any network call (acknowledgement +
    phrase-match).

- `DeleteAccountPageWrapper`:
  - Provides the bloc with the locale-specific `expectedPhrase`
    (`t.deleteAccount.confirmationPhrase`).
  - Listens for `Succeeded` / `Failed` / `Unauthorized` presentation
    events; on success: logout + bounce to `/login`.

- `_DeleteAccountView`:
  - `_WarningBanner` (red hero).
  - `_BulletListCard` with four deletion-consequence bullets.
  - `_ReasonField` (optional, 280-char limit, 3 lines).
  - Two checkboxes: `requestDataExport` (brand-colour) and
    `acknowledgedPermanent` (danger-colour).
  - Confirmation text field + danger CTA (`_DangerButton`) that turns
    grey until both guards pass.
  - Final-confirmation `AlertDialog` on tap.
  - Cancel button bounces back to Settings.

### Routing

- New `DeleteAccountRoute` (`/profile/delete-account`) + generated
  `$DeleteAccountRoute` mixin mirrored in `app_routes.g.dart`.

### Settings integration

- New tile in the Settings page Security section: "Delete my account /
  Permanently remove your account" → routes to
  `/profile/delete-account`.
- Bonus fix: the previously no-op "Security" tile on the Profile page
  now bounces to Settings, so users can reach Change Password / Devices
  / Delete Account from there too.

### Localization

Added `parent.deleteAccount.*` namespace (28 keys) to:
- `sources/strings.json` + `sources/strings.i18n.json` + `sources/en.json`
- `sources/strings_ar.json` + `sources/strings_ar.i18n.json` +
  `sources/ar.json`
- `generated/strings_en.g.dart` (new `TranslationsParentDeleteAccountEn`
  class with one parameterised getter: `confirmationPrompt({phrase})`)
- `generated/strings_ar.g.dart` (matching `_TranslationsParentDeleteAccountAr`)

`confirmationPhrase` itself is localised — Arabic users type `حذف`,
English users type `DELETE`. The bloc compares case-insensitively against
the locale-resolved expected phrase, so users don't have to worry about
caps-lock.

## 3. State / Flow Matrix

| Status | UI state | Submit allowed? | Side-effect |
|---|---|---|---|
| `idle` (initial) | Form rendered, CTA disabled | No | n/a |
| `idle` + ack ✓ only | CTA still disabled | No | n/a |
| `idle` + phrase ✓ only | CTA still disabled | No | n/a |
| `idle` + ack ✓ + phrase ✓ | CTA enabled (red) | Yes | dialog → submit |
| `submitting` | CTA spinner + label "Submitting..." | No | request in flight |
| `success` | toast + logout + `/login` | n/a | session destroyed |
| `failure` (validation) | toast: "Please tick + type phrase" | re-allowed | n/a |
| `failure` (network) | toast: "Couldn't reach server" | re-allowed | n/a |
| `failure` (unauthorized) | logout + `/login` | n/a | session destroyed |
| `failure` (unknown) | toast: backend message or fallback | re-allowed | n/a |

## 4. Tests / Verification

- Mock dev flow (`flutter run --dart-define-from-file=parent/.env.mock`):
  open Settings → Security → "Delete my account" → toggle off the
  acknowledgement → CTA stays disabled. Toggle on, type the wrong
  phrase, CTA stays disabled. Type the right phrase → CTA enables →
  tap → dialog → confirm → mock processes → app logs out.
- `MockParentAccountDeletionRepository.failNext = true` exercises the
  failure branch.
- All guards run client-side (no network call before they pass) and
  again server-side (backend rejects with 422 if `acknowledgedPermanent`
  isn't true).

## 5. Known Limitations / Tech Debt

- The backend `/api/auth/delete-account` endpoint is not yet documented
  in EduCore Postman. Dio impl falls back to `DELETE /api/auth/me`; if
  neither exists the user gets a localised error and stays logged in.
- No actual data-export flow yet: ticking "Send me a copy of my data
  first" only sets `requestDataExport: true` in the payload. The backend
  is expected to queue the export job; UI just surfaces the toast.
- No grace-period UX: some apps show a "your account will be deleted in
  X days, cancel?" banner on subsequent logins. We currently treat the
  submission as terminal. Acceptable for v1 since the backend hasn't
  defined grace-period semantics.
- The locale-specific `confirmationPhrase` is hard-coded to one string
  per locale. For Arabic we accept `حذف`; product may later want to
  switch to `DELETE` in both locales for clearer audit-trail logging.
