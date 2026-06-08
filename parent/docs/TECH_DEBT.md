# Parent App — Technical Debt Register

Captured at the end of Priority 5. Anything listed here is *known* and
*intentionally deferred* — not a bug, not an oversight. New debt should be
added to this list before being introduced.

Each item is rated by:
- **Impact**: how loudly the debt surfaces in day-to-day work.
- **Risk to fix**: how disruptive a clean-up would be.
- **Suggested owner**: which Priority should sweep it up.

---

## D1. `appEventBus` is a top-level singleton, not injected

- **Where**: `core/events/app_global_events.dart`.
- **Impact**: Medium. Bloc tests cannot easily swap or assert against the
  bus. Two cubits and one widget reach into the global directly.
- **Risk to fix**: Medium. Converting to a `RepositoryProvider<EventBus>`
  means updating every fire/listen site, including tests.
- **Owner**: future Priority — bundle with introducing widget tests.

## D2. Profile feature has no Bloc

- **Where**: `features/profile/` exposes pages + widgets only; reads user
  data directly from `AppAuthenticationCubit`.
- **Impact**: Low at rest, High once edit-profile is implemented. There is
  currently no place to hang profile-mutation events.
- **Risk to fix**: Low — a thin Bloc can be introduced when the edit flow
  starts; deletion of the placeholder bloc files (Priority 3) removed the
  red herring.
- **Owner**: the priority that ships Profile Edit (currently scheduled as
  a post-stabilisation Feature).

## D3. `mock_notification_repository` is imported from `packages/mock/student/`

- **Where**: `parent/pubspec.yaml` depends on
  `path: ../packages/mock/student/mock_notification_repository`.
- **Impact**: Low at runtime. Tight coupling between the two apps at the
  build-graph level.
- **Risk to fix**: Medium. Requires either lifting the mock into a shared
  `packages/mock/common/` or vendoring a parent-local copy.
- **Owner**: future Priority — bundle with the next round of package
  reorganization.

## D4. No widget / bloc unit tests for Parent

- **Where**: `parent/test/` only contains stubs.
- **Impact**: Medium. Refactors rely on static analysis + grep only; future
  regressions could ship undetected.
- **Risk to fix**: Low per-bloc; cumulative.
- **Owner**: future Priority dedicated to "Test Coverage Lift".

## D5. Backend contract gaps documented in `MOCK_FEATURES.md`

- **Where**: 9 endpoints in `packages/parent/dio_*` call paths the EduCore
  backend does not yet expose (registration, find-student, link/unlink,
  per-child grades, payments, wallet analytics, WhatsApp groups,
  recent-activity, FCM token).
- **Impact**: High for those specific features in production.
- **Risk to fix**: External — needs backend work, not frontend.
- **Owner**: backend engineering; the frontend already degrades gracefully
  on 404 / 405 (Priority 1).

## D6. `course_progress/{sessionId}` vs `courseId` naming mismatch

- **Where**: `dio_course_repository.getCourseProgress` passes a courseId
  into a path the backend calls `sessionId`.
- **Impact**: Low — opaque ids interchangeably accepted on the wire.
- **Risk to fix**: Low cosmetic. Rename in the abstract repo + bloc.
- **Owner**: when grades/courses get their first real refactor.

## D7. `LoginSubmittedEvent.fcmToken` is always null

- **Where**: `features/auth/pages/login/bloc/login_event.dart`.
- **Impact**: Low. No FCM service is wired into the app; the field is a
  forward-compatibility hook only.
- **Risk to fix**: Touches the Auth flow at multiple call sites.
- **Owner**: the priority that ships push notifications.

## D8. Reset Password fallback may silently retry with a different payload

- **Where**: `DioAuthenticationRepository.resetPassword`.
- **Impact**: Low. On a 400/422 the call retries with snake_case keys; if
  *both* shapes succeed (extremely unlikely) the user has no visibility into
  which path completed.
- **Risk to fix**: Low — remove the fallback once Backend confirms the
  canonical shape.
- **Owner**: when Backend ratifies the auth contract.

## D9. `dart-define-from-file=.env` not invoked from `makefile`

- **Where**: `parent/makefile`.
- **Impact**: Low. Developers must remember the flag manually.
- **Risk to fix**: Trivial — append a `run:` rule.
- **Owner**: any contributor.

---

If you fix something in this list, delete its entry and link the PR /
commit in the commit message so future audits can see why it disappeared.
