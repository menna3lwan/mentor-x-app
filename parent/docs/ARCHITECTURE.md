# Parent App — Architecture Notes

Snapshot taken after Priority 5 (Architecture Cleanup & Refactoring).

## High-level layout

```
parent/
├── lib/
│   ├── main.dart                       # entry point; runs ParentApp
│   ├── app/
│   │   ├── parent_app.dart             # root widget: providers + MaterialApp.router
│   │   ├── parent_requirements.dart    # boot orchestration: services → repos → blocs → router
│   │   └── initializers/
│   │       ├── services_factory.dart   # DeviceInfoService
│   │       ├── repositories_factory.dart  # CacheRepository + HttpClient + 9 repos
│   │       └── blocs_factory.dart      # App-wide cubits (auth / locale / brightness)
│   ├── core/
│   │   ├── blocs/
│   │   │   ├── app_authentication_cubit/
│   │   │   ├── app_brightness_cubit/
│   │   │   ├── app_locale_cubit/
│   │   │   ├── notifications_badge_cubit/
│   │   │   └── bloc_error_helpers.dart   # shared describeError / classifyHttpFailure
│   │   ├── events/app_global_events.dart # singleton EventBus + sealed events
│   │   ├── routing/
│   │   │   ├── app_router.dart          # GoRouter wrapper with auth redirect
│   │   │   └── app_routes.dart          # typed go_router routes
│   │   ├── utils/
│   │   │   ├── env.dart                 # compile-time defines
│   │   │   ├── parent_cache_keys.dart   # cache keys scoped to parent
│   │   │   └── validator_function.dart
│   │   └── widgets/app_refresh_listener.dart
│   └── features/
│       ├── auth/        (login, register, forget-password, OTP)
│       ├── home/        (dashboard composite)
│       ├── children/    (link / unlink / lookup)
│       ├── attendance/  (per-child attendance monitor)
│       ├── courses/     (academic monitor + course progress)
│       ├── assessments/ (grade summary + assessments list)
│       ├── financial/   (wallet summary + transactions)
│       ├── communication/ (announcements archive + WhatsApp groups)
│       ├── notifications/ (generic notifications inbox)
│       ├── profile/     (read-only profile view)
│       └── onboarding/  (splash + 3-slide intro)
└── docs/
    ├── ARCHITECTURE.md       # ← you are here
    ├── MOCK_FEATURES.md      # what degrades in prod when backend lacks an endpoint
    └── TECH_DEBT.md          # remaining debt and rationale
```

## Conventions

- **Repositories** live in `packages/parent/dio_*` (live) and
  `packages/mock/parent/mock_*` (fixtures). Both implement an abstract
  interface declared in `mentorx_core`.
- **Blocs** use `flutter_bloc` + `bloc_presentation` + `bloc_concurrency`.
  Side effects (toasts, navigation, auth redirects) are emitted as
  presentation events; the bloc itself never touches `BuildContext`.
- **Pages** are split into `*_page.dart` (pure layout, no DI) and
  `*_wrapper.dart` (BlocProvider + presentation listener + navigation).
  Widgets inside `features/*/widgets/` follow the same pattern at the
  component level: `foo.dart` (entry), `foo_widget.dart` (pure view),
  `foo_wrapper.dart` (BlocBuilder + section retry).
- **Routing** is type-safe via `TypedGoRoute`. The single redirect lives in
  `AppRouter` and bounces unauthenticated users to `/login`.
- **Error handling** runs through `bloc_error_helpers.dart`:
  - `error.describeError()` — best-effort string for toasts.
  - `classifyHttpFailure(error)` — `GenericFailureKind`.
  - `isUnauthorizedError(error)` — used by every dashboard to fire its
    `*UnauthorizedPresentationEvent`.
- **Configuration** is compile-time via `--dart-define-from-file=.env`.
  Defaults in `Env.dart` ship every repository in `prod` mode; `.env.mock`
  flips them all to mock for local development.

## Initialization sequence (cold start)

1. `main()` → `ParentRequirements.initialize()`.
2. `_initSystemUIStyle` sets status / nav bar appearance.
3. `ServicesFactory.initServices` builds `DeviceInfoService`.
4. `RepositoriesFactory.initRepositories`:
   - asserts `MENTORX_API_BASE_URL` if any repo is `prod`,
   - memoised `_initCacheRepository`,
   - memoised `_initHttpClient` (only when needed),
   - parallel build of 9 repository instances inside `Future.wait`.
5. Read cached language + brightness.
6. Read cached user (if any) → seed `AppAuthenticationCubit`.
7. `BlocsFactory.initBlocs` builds auth/locale/brightness cubits.
8. Build `AppRouter` with the auth cubit; the redirect listens to cubit
   stream and re-routes immediately on login / logout.
9. `runApp(ParentApp(requirements))`.

## What lives outside Parent

- `packages/mentorx_core` — entities, repository interfaces,
  `HttpClient`, `CacheKeys` (shared with Student).
- `packages/mentorx_ui` — theming, translations (`en.json` / `ar.json`),
  shared widgets (`MentorXButton`, `MentorXTextFormField`, …).
- `packages/clients/dio_http_client` — concrete `DioHttpClient` with
  refresh-token interceptor.
- `packages/parent/*` — Dio implementations of repositories.
- `packages/mock/parent/*` — fixture implementations of the same.
- `packages/services/device_info_service` — device hash / app version.

See `MOCK_FEATURES.md` for the runtime feature matrix and
`TECH_DEBT.md` for known limitations not yet addressed.
