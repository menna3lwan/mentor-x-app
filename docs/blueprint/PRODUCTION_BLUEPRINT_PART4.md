# PRODUCTION BLUEPRINT — Part 4: Master Build Order + Quick-Action Checklists

---

## MASTER BUILD ORDER

Build a new monorepo project from scratch, in this exact sequence. Each step depends on the ones before it.

---

### PHASE 1: WORKSPACE FOUNDATION

#### Step 1.1 — Create root workspace

```
mkdir {{project_name}}-mobile && cd {{project_name}}-mobile
```

Create root `pubspec.yaml`:

```yaml
name: {{project_name}}_workspace
publish_to: none

environment:
  sdk: ^3.9.2

workspace:
  - packages/{{project_name}}_core
  - packages/clients/dio_http_client
  - packages/common/flutter_secure_storage_cache_repository
  - packages/{{project_name}}_ui
  - packages/mock_data
  # Dio repos (add as created):
  - packages/{{project_name}}/dio_authentication_repository
  # Mock repos (add as created):
  - packages/mock/mock_authentication_repository
  # Main app:
  - {{project_name}}

dev_dependencies:
  melos: ^7.1.0
```

Create root `analysis_options.yaml`:

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    deprecated_member_use: ignore

formatter:
  trailing_commas: preserve
```

#### Step 1.2 — Initialize Git

```bash
git init
# Create .gitignore with Flutter defaults + melos patterns
```

---

### PHASE 2: DOMAIN CORE (`{{project_name}}_core`)

**Pattern reference**: Part 1, Pattern 2

#### Step 2.1 — Create package skeleton

```bash
mkdir -p packages/{{project_name}}_core/lib/src/{entities,repositories,utils}
```

#### Step 2.2 — Create `pubspec.yaml`

```yaml
name: {{project_name}}_core
version: 1.0.0
publish_to: none
resolution: workspace
environment:
  sdk: ^3.9.2
dependencies:
  equatable: ^2.0.7
  intl: ^0.20.2
dev_dependencies:
  lints: ^6.0.0
  test: ^1.24.0
```

#### Step 2.3 — Create single-library barrel

`lib/{{project_name}}_core.dart`:

```dart
library;
// All files below use: part of '{{project_name}}_core.dart';

// Utils
part 'src/utils/{{project_name}}_exception.dart';
part 'src/utils/{{project_name}}_logger.dart';
part 'src/utils/{{project_name}}_nullable_value.dart';
part 'src/utils/{{project_name}}_pagination_info.dart';
part 'src/utils/cache_keys.dart';
part 'src/utils/date_time_utils.dart';

// Entities
part 'src/entities/user_entity.dart';
part 'src/entities/location_entity.dart';
// ... add entities as domain grows

// Repositories
part 'src/repositories/cache_repository.dart';
part 'src/repositories/authentication_repository.dart';
part 'src/repositories/http_client.dart';
part 'src/repositories/http_client_repository.dart';
// ... add repositories as domain grows
```

#### Step 2.4 — Build foundation utilities

Create IN THIS ORDER (each may depend on the previous):

1. `{{project_name}}_exception.dart` — Generic exception with code enum
2. `{{project_name}}_logger.dart` — Debug logger with tag
3. `{{project_name}}_nullable_value.dart` — Nullable field wrapper for copyWith
4. `{{project_name}}_pagination_info.dart` — Page/hasMore/total
5. `cache_keys.dart` — String constants for cache keys
6. `date_time_utils.dart` — Date formatting/parsing helpers

#### Step 2.5 — Build core entities

Create entities in dependency order:

1. Country enum (with `code`, `phoneCode`, `flag`)
2. `LocationEntity` (with `defaultLocation` static)
3. `UserEntity` (depends on Country)
4. Domain-specific entities as needed

Each entity: `Equatable`, `copyWith`, `placeholder` static, `fromJson`/`toJson`.

#### Step 2.6 — Build repository interfaces

Create interfaces in this order:

1. `CacheRepository` (abstract interface — no dependencies)
2. `HttpClient` (abstract interface — defines HTTP contract)
3. `LocalizedClient` (abstract interface — `languageCode` + `updateLanguageCode`)
4. `HttpClientRepository` (abstract base class — error handling template)
5. `AuthenticationRepository` (depends on User, Country)
6. Domain-specific repositories as needed

#### Step 2.7 — Verify

```bash
cd packages/{{project_name}}_core && flutter pub get && dart analyze
```

---

### PHASE 3: HTTP CLIENT (`dio_http_client`)

**Pattern reference**: Part 1, Pattern 3

#### Step 3.1 — Create package

```bash
mkdir -p packages/clients/dio_http_client/lib/src
```

#### Step 3.2 — Create files

1. `pubspec.yaml` — deps: `dio ^5.9.0`, `jwt_decoder ^2.0.1`, `{{project_name}}_core`
2. `lib/dio_http_client.dart` — barrel
3. `lib/src/dio_http_client.dart` — implements `HttpClient` + `LocalizedClient`
4. `lib/src/refresh_token_interceptor.dart` — 401 handling with `Completer`

#### Step 3.3 — Verify

```bash
cd packages/clients/dio_http_client && flutter pub get && dart analyze
```

---

### PHASE 4: CACHE REPOSITORY (`flutter_secure_storage_cache_repository`)

**Pattern reference**: Part 2, Pattern 6

#### Step 4.1 — Create package

```bash
mkdir -p packages/common/flutter_secure_storage_cache_repository/lib/src
```

#### Step 4.2 — Create files

1. `pubspec.yaml` — deps: `flutter_secure_storage ^9.2.4`, `{{project_name}}_core`
2. `lib/flutter_secure_storage_cache_repository.dart` — barrel
3. `lib/src/flutter_secure_storage_cache_repository.dart` — implements `CacheRepository`

#### Step 4.3 — Verify

```bash
flutter pub get && dart analyze
```

---

### PHASE 5: MOCK DATA (`mock_data`)

**Pattern reference**: Part 2, Pattern 7

#### Step 5.1 — Create package

```bash
mkdir -p packages/mock_data/lib/src/{generators,localization/models,cache,state,utils,clients}
```

#### Step 5.2 — Create files

1. `pubspec.yaml` — deps: `faker ^2.1.0`, `equatable ^2.0.7`, `{{project_name}}_core`
2. `lib/mock_data.dart` — barrel (uses `export`, NOT `part`)
3. `MockLocalizedClient` — implements core's `LocalizedClient`
4. `MockCachingStrategy` — enum: `inMemory`, `secureStorage`
5. Localized data models — bilingual containers per entity
6. Generators — one per entity type
7. Cache system — in-memory store, cache manager
8. State — data store, relationship manager, ID generator

#### Step 5.3 — Verify

```bash
flutter pub get && dart analyze
```

---

### PHASE 6: DIO REPOSITORIES (one per domain entity)

**Pattern reference**: Part 1, Pattern 4

For EACH repository needed (auth, cart, vendor, etc.):

#### Step 6.1 — Create package

```bash
mkdir -p packages/{{project_name}}/dio_{{entity}}_repository/lib/{src,models}
```

#### Step 6.2 — Create files

1. `pubspec.yaml` — deps: `{{project_name}}_core`, `dio_http_client`
2. Barrel file
3. Models (extend entities with `fromJson`/`toJson`/`fromEntity`)
4. Repository implementation (`extends HttpClientRepository<ExceptionCode> implements XRepository`)

#### Step 6.3 — Register in root `pubspec.yaml` workspace list

#### Step 6.4 — Verify

```bash
flutter pub get && dart analyze
```

**Repeat for each domain repository.**

---

### PHASE 7: MOCK REPOSITORIES (one per domain entity)

**Pattern reference**: Part 1, Pattern 5

For EACH repository:

#### Step 7.1 — Create package

```bash
mkdir -p packages/mock/mock_{{entity}}_repository/lib/src
```

#### Step 7.2 — Create files

1. `pubspec.yaml` — deps: `{{project_name}}_core`, `mock_data`
2. Barrel file
3. Repository implementation (implements same interface, uses generators + configurable delay)

#### Step 7.3 — Register in root workspace

#### Step 7.4 — Verify

**Repeat for each domain repository.**

---

### PHASE 8: UI KIT (`{{project_name}}_ui`)

**Pattern reference**: Part 2, Pattern 8

#### Step 8.1 — Create package structure

```bash
mkdir -p packages/{{project_name}}_ui/lib/{theming,extensions,utils,widgets,localization/{sources,generated},assets/{gen,images,svgs,icons}}
```

#### Step 8.2 — Create config files

1. `pubspec.yaml` — deps: `mix ^1.7.0`, `slang ^4.8.1`, `gap ^3.0.1`, etc.
2. `build.yaml` — `slang_build_runner: enabled: false`, `flutter_gen_runner: enabled: true`
3. `slang.yaml` — `base_locale: en`, `output_directory: lib/localization/generated`

#### Step 8.3 — Build theming system (in order)

1. `{{project_name}}_theme_tokens.dart` — `${{project_name}}Token` const with color/text/radius tokens
2. `{{project_name}}_theme_color_palette.dart` — light/dark static const palettes
3. `{{project_name}}_themes.dart` — `MixThemeData` factory mapping tokens → palette values + Material bridge
4. `{{project_name}}_theme_extension.dart` — `BuildContext` extension (token → concrete value)
5. `{{project_name}}_theme_provider.dart` — `MixTheme` wrapper widget

#### Step 8.4 — Build localization

1. Create `lib/localization/sources/strings_en.json` and `strings_ar.json`
2. Run `dart run slang` to generate `lib/localization/generated/`
3. Create `{{project_name}}_translation_provider.dart` — wraps slang's `TranslationProvider`

#### Step 8.5 — Build single-library barrel

`lib/{{project_name}}_ui.dart`:

```dart
library;
// imports...
part 'theming/{{project_name}}_theme_tokens.dart';
part 'theming/{{project_name}}_theme_color_palette.dart';
// ... all parts
```

#### Step 8.6 — Build foundation widgets

1. Platform checker utility
2. Context extensions (themes, bottom sheets, dialogs, locale)
3. `{{Project}}Button` (Mix Variant-based)
4. `{{Project}}BottomSheet` (platform-adaptive)
5. `{{Project}}TextFormField`
6. `{{Project}}ErrorIndicator`
7. `{{Project}}SkeletonProvider`
8. Add more widgets as features demand them

#### Step 8.7 — Add assets and generate

1. Place SVGs in `lib/assets/svgs/` and `lib/assets/icons/`
2. Place images in `lib/assets/images/`
3. Run `dart run build_runner build --delete-conflicting-outputs` for FlutterGen
4. Add fonts to pubspec flutter section

#### Step 8.8 — Verify

```bash
flutter pub get && dart run slang && dart run build_runner build --delete-conflicting-outputs && dart analyze
```

---

### PHASE 9: MAIN APP — CORE LAYER

**Pattern reference**: Part 3, Pattern 9

#### Step 9.1 — Create app

```bash
flutter create {{project_name}} --org com.{{org}} --platforms ios,android
cd {{project_name}}
```

#### Step 9.2 — Configure `pubspec.yaml`

Add ALL package dependencies (path-based), configure fonts, FlutterGen, SVG transformers.

#### Step 9.3 — Create `dev.env`

All environment variables: API URLs, repo modes (MOCK/PROD), mock config.

#### Step 9.4 — Create `build.yaml`

Enable `go_router_builder` only.

#### Step 9.5 — Create `makefile`

Three targets: `update_localization`, `generate`, `clean_and_get`.

#### Step 9.6 — Build core utilities

1. `lib/core/utils/env.dart` — `RepositoryMode` enum + `Env` class with all `String.fromEnvironment`
2. `lib/core/utils/extensions/navigation_extensions.dart`
3. `lib/core/utils/input_formatters/` — phone number formatter, etc.

#### Step 9.7 — Build EventBus infrastructure

1. `lib/core/events/app_global_events.dart` — `AppRefreshEvent`, `AppPostLoginNavigationEvent`
2. `lib/core/widgets/app_refresh_listener.dart` — EventBus-driven refresh widget

#### Step 9.8 — Build app-level cubits

Create each cubit folder under `lib/core/blocs/`:

1. `app_locale_cubit/` — language state, EventBus listener, cache persistence
2. `app_authentication_cubit/` — user state, login/logout detection, refresh on change
3. `app_brightness_cubit/` — brightness state, platform listener
4. `app_location_cubit/` — geolocation, reverse geocoding, cache
5. `app_events_cubit/` — upcoming/past events
6. `app_notifications_cubit/` — new/earlier split, unread count
7. `app_navigation_cubit/` — post-login navigation callback storage

#### Step 9.9 — Build barrel files

```
lib/core/core.dart          → exports utils, routing, blocs, events, widgets
lib/core/utils/utils.dart   → exports env and extensions
lib/core/routing/routing.dart
lib/core/blocs/blocs.dart   → exports all cubit folders
lib/core/events/events.dart
lib/core/widgets/widgets.dart
```

#### Step 9.10 — Build initializers

1. `lib/app/initializers/repositories_factory.dart` — `AppRepositories` + `RepositoriesFactory`
2. `lib/app/initializers/blocs_factory.dart` — `AppBlocs` + `BlocsFactory`
3. `lib/app/initializers/initializers.dart` — barrel

#### Step 9.11 — Build app shell

1. `lib/app/{{project_name}}.dart` — root widget with `appEventBus`, `rootNavigatorKey`
2. `lib/app/{{project_name}}_requirements.dart` — initialization pipeline
3. `lib/app/app.dart` — barrel
4. `lib/main.dart` — entry point with splash timing

#### Step 9.12 — Verify (should compile with empty features)

```bash
flutter pub get
flutter run --dart-define-from-file=dev.env
```

---

### PHASE 10: MAIN APP — ROUTING SHELL

#### Step 10.1 — Create routing infrastructure

1. `lib/core/routing/app_routes.dart` — central file with imports (initially empty parts)
2. `lib/core/routing/app_router.dart` — GoRouter wrapper

#### Step 10.2 — Create onboarding feature (first feature)

1. Initial language page (route + page + wrapper)
2. Initial location page (optional)
3. Register routes in `app_routes.dart`

#### Step 10.3 — Create main page shell

1. `main_page_route.dart` — `@TypedStatefulShellRoute<MainPageRoute>` with branches
2. Bottom navigation bar integration

#### Step 10.4 — Run code generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### Step 10.5 — Verify navigation

```bash
flutter run --dart-define-from-file=dev.env
```

---

### PHASE 11: MAIN APP — FEATURES

**Pattern reference**: Part 3, Pattern 10

Build features in dependency order:

#### Step 11.1 — Auth feature (first — others depend on it)

1. Login page (full-page + bottom sheet variants)
2. OTP page (full-page + bottom sheet variants)
3. `LoginPageBottomSheet` with `showWithNavigation` pattern
4. Register routes

#### Step 11.2 — Home feature

1. Home page with parallel data loading
2. `AppRefreshListener` integration
3. Register as shell route branch 0

#### Step 11.3 — Remaining features (any order)

For each: follow the **Feature Checklist** (Pattern 10.11):

1. Create folder → barrel → register in features.dart
2. Create page → bloc → wrapper → route
3. Register route in app_routes.dart
4. Run codegen
5. Add to shell branch (if tab)

#### Step 11.4 — Final verification

```bash
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define-from-file=dev.env
```

---

## QUICK-ACTION CHECKLISTS

### Checklist A: Add a new entity

1. Create `{{entity}}_entity.dart` in `{{project_name}}_core/lib/src/entities/`
2. File header: `part of '{{project_name}}_core.dart';`
3. Extend `Equatable`, add `copyWith`, `placeholder`, `fromJson`, `toJson`
4. Register in barrel: add `part` directive to `{{project_name}}_core.dart`
5. Run `flutter pub get` in core package

### Checklist B: Add a new repository

1. **Interface** — `{{project_name}}_core/lib/src/repositories/{{entity}}_repository.dart`
   - `part of '{{project_name}}_core.dart';`
   - `abstract interface class {{Entity}}Repository`
   - Create `{{Entity}}RepositoryException extends {{Project}}Exception<{{Entity}}ExceptionCode>`
   - Register in core barrel

2. **Dio implementation** — `packages/{{project_name}}/dio_{{entity}}_repository/`
   - pubspec.yaml (deps: core, dio_http_client)
   - Barrel file
   - Models in `lib/models/` (fromJson/toJson/fromEntity)
   - `DioXRepository extends HttpClientRepository<ExceptionCode> implements XRepository`
   - Register in root workspace

3. **Mock implementation** — `packages/mock/mock_{{entity}}_repository/`
   - pubspec.yaml (deps: core, mock_data)
   - Barrel file
   - `MockXRepository implements XRepository` with delay + generators
   - Register in root workspace

4. **Mock data** — `packages/mock_data/lib/src/generators/{{entity}}_generator.dart`
   - Add localized data model if bilingual
   - Add generator
   - Export from mock_data barrel

5. **Wire into app** —
   - Add `{{entity}}RepositoryMode` to `Env`
   - Add `{{ENTITY}}_REPOSITORY_MODE=MOCK` to `dev.env`
   - Add field to `AppRepositories`
   - Add `_init{{Entity}}Repository()` to `RepositoriesFactory`
   - Add to `Future.wait` list + destructuring
   - Add to `toProviders()`

6. **Verify** — `flutter pub get && dart analyze` at root

### Checklist C: Add a new feature

1. `lib/features/{{feature}}/{{feature}}.dart` → `export 'pages/pages.dart';`
2. `lib/features/{{feature}}/pages/pages.dart` → `export '{{page}}/{{page}}.dart';`
3. Register: `lib/features/features.dart` → `export '{{feature}}/{{feature}}.dart';`
4. Create page folder:
   - `{{page}}_page.dart` — pure UI with widget slots
   - `{{page}}_page_route.dart` — `part of app_routes.dart`, `@TypedGoRoute`, BlocProvider
   - `{{page}}_page_wrapper.dart` — BlocPresentationListener + context.select → page
   - `bloc/{{page}}_bloc.dart` + `_event.dart` + `_state.dart` (use `part`)
5. Register route: add `part` directive to `core/routing/app_routes.dart`
6. If shell tab: add `TypedStatefulShellBranch` to `MainPageRoute` + nav bar item
7. Run: `dart run build_runner build --delete-conflicting-outputs`

### Checklist D: Add a new app-level cubit

1. Create `lib/core/blocs/app_{{name}}_cubit/`
   - `app_{{name}}_cubit.dart` — extends `Cubit`, subscribes to EventBus
   - `app_{{name}}_events.dart` — sealed Equatable event classes
   - `app_{{name}}_listener.dart` — BlocBuilder convenience widget (optional)
   - `app_{{name}}_state.dart` — Equatable state (or `part of` cubit)
2. Export from `lib/core/blocs/blocs.dart`
3. Add field to `AppBlocs` class
4. Create instance in `BlocsFactory.initBlocs()`
5. Add to `AppBlocs.toProviders()`
6. Access in features via `context.read<App{{Name}}Cubit>()`

### Checklist E: Add a new UI widget to the kit

1. Create `packages/{{project_name}}_ui/lib/widgets/{{project_name}}_{{widget}}.dart`
2. File header: `part of '../{{project_name}}_ui.dart';`
3. Use Mix tokens: `context.brandPrimaryColor`, `context.bodyTextStyle`, `context.mediumRadius`
4. Support `isLoading` + `isDisabled` parameters where applicable
5. Register in barrel: add `part 'widgets/{{project_name}}_{{widget}}.dart';` to `{{project_name}}_ui.dart`
6. Run `flutter pub get` in UI package

### Checklist F: Add a new locale

1. Create `packages/{{project_name}}_ui/lib/localization/sources/strings_{{ll}}.json`
2. Copy structure from `strings_en.json`, translate values
3. If the locale needs a plural resolver:

   ```dart
   // In {{Project}}Requirements._initLocalizationSettings()
   LocaleSettings.setPluralResolver(
     locale: AppLocale.{{ll}},
     cardinalResolver: (n, {few, many, one, other, two, zero}) { ... },
   );
   ```

4. Run: `cd packages/{{project_name}}_ui && dart run slang`
5. Verify generated files in `lib/localization/generated/`

### Checklist G: Add a new design token

1. **Token**: Add getter to relevant token class in `{{project_name}}_theme_tokens.dart`

   ```dart
   ColorToken get newTokenName => const ColorToken('newTokenName');
   ```

2. **Palette**: Add field to `{{Project}}ThemeColorPalette` + light/dark const values
3. **Theme**: Map token → palette value in `{{Project}}Themes.fromColorPalette()`
4. **Extension**: Add getter to `{{Project}}ThemeExtension` on BuildContext

   ```dart
   Color get newTokenNameColor => theme.colors[${{project_name}}Token.color.newTokenName]!;
   ```

5. Use: `context.newTokenNameColor`

### Checklist H: Switch a repository from MOCK to PROD

1. Create the `dio_{{entity}}_repository` package (if not already)
2. In `dev.env`: change `{{ENTITY}}_REPOSITORY_MODE=PROD`
3. Verify `Env.{{entity}}RepositoryMode` reads the new value
4. Verify `RepositoriesFactory._init{{Entity}}Repository()` handles `RepositoryMode.prod`
5. Run: `flutter run --dart-define-from-file=dev.env`

No code changes needed — it's entirely configuration-driven.

### Checklist I: Add environment-specific configs (staging, prod)

1. Create `staging.env` and `prod.env` alongside `dev.env`
2. Set appropriate values (different API URLs, all repos PROD, no mock delay)
3. Run with: `flutter run --dart-define-from-file=staging.env`
4. Build with: `flutter build apk --dart-define-from-file=prod.env`

---

## DEPENDENCY GRAPH

```
                    ┌─────────────────────┐
                    │   {{project_name}}_core    │  ← Pure Dart, zero Flutter
                    │  (entities, repos,   │
                    │   interfaces, utils) │
                    └──────────┬──────────┘
                               │
            ┌──────────────────┼──────────────────┐
            │                  │                  │
            ▼                  ▼                  ▼
   ┌────────────────┐  ┌──────────────┐  ┌────────────────────────┐
   │ dio_http_client│  │  mock_data   │  │ flutter_secure_storage │
   │ (Dio impl of   │  │  (faker,     │  │ _cache_repository      │
   │  HttpClient)   │  │  generators) │  │ (CacheRepository impl) │
   └───────┬────────┘  └──────┬───────┘  └────────────┬───────────┘
           │                  │                        │
           ▼                  ▼                        │
   ┌────────────────┐  ┌──────────────┐               │
   │  dio_*_repo    │  │  mock_*_repo │               │
   │  (per entity)  │  │  (per entity)│               │
   └───────┬────────┘  └──────┬───────┘               │
           │                  │                        │
           └──────────────────┼────────────────────────┘
                              │
                    ┌─────────▼───────────┐
                    │  {{project_name}}_ui       │  ← Flutter, theming,
                    │  (Mix, slang, widgets)│     localization, widgets
                    └─────────┬───────────┘
                              │
                    ┌─────────▼───────────┐
                    │  {{project_name}}/         │  ← Main app
                    │  (shell, features,   │
                    │   routing, blocs)    │
                    └─────────────────────┘
```

**Import rules**:

- Core may NOT import anything except Dart/pub packages
- HTTP client imports only core
- Mock data imports only core
- Cache repo imports only core
- Dio repos import core + HTTP client
- Mock repos import core + mock data
- UI kit imports core (for entity types in widgets)
- Main app imports EVERYTHING
- Features import NOTHING from each other — only through core cubits/events

---

## TECH STACK REFERENCE

| Layer | Package | Version | Purpose |
|-------|---------|---------|---------|
| State | `bloc` | ^9.1.0 | BLoC pattern core |
| State | `flutter_bloc` | ^9.1.1 | Flutter BLoC widgets |
| State | `bloc_presentation` | ^1.1.1 | One-time presentation events |
| Navigation | `go_router` | ^16.2.4 | Declarative routing |
| Navigation | `go_router_builder` | ^4.1.0 | Type-safe route codegen |
| HTTP | `dio` | ^5.9.0 | HTTP client |
| HTTP | `jwt_decoder` | ^2.0.1 | JWT token parsing |
| Theming | `mix` | ^1.7.0 | Design token system |
| Localization | `slang` | ^4.8.1 | Type-safe i18n |
| Localization | `slang_flutter` | ^4.8.0 | Flutter integration |
| Assets | `flutter_gen_runner` | ^5.12.0 | Asset codegen |
| Assets | `vector_graphics_compiler` | (transformer) | SVG pre-compilation |
| Cache | `flutter_secure_storage` | ^9.2.4 | Encrypted storage |
| Events | `event_bus` | ^2.0.1 | Cross-feature events |
| Equality | `equatable` | ^2.0.7 | Value equality |
| Mock | `faker` | ^2.1.0 | Fake data generation |
| UI | `gap` | ^3.0.1 | Sized gaps |
| UI | `skeletonizer` | ^2.1.0 | Loading skeletons |
| UI | `cached_network_image` | ^3.4.1 | Image caching |
| UI | `flutter_animate` | ^4.5.2 | Animations |
| UI | `fluttertoast` | ^9.0.0 | Toast messages |
| UI | `country_flags` | ^4.1.0 | Country flag widgets |
| Platform | `geolocator` | ^14.0.2 | GPS location |
| Platform | `permission_handler` | ^12.0.1 | Runtime permissions |
| Platform | `smart_auth` | (latest) | SMS autofill |
| Codegen | `build_runner` | ^2.7.1 | Code generation runner |
| Workspace | `melos` | ^7.1.0 | Monorepo management |

---

## CODE GENERATION COMMANDS

```bash
# From root workspace:
melos bootstrap                        # Install all deps

# From {{project_name}}_ui/:
dart run slang                          # Generate localization
dart run build_runner build --delete-conflicting-outputs  # FlutterGen

# From {{project_name}}/ (main app):
dart run build_runner build --delete-conflicting-outputs  # GoRouter routes

# Run app:
flutter run --dart-define-from-file=dev.env

# Build release:
flutter build apk --dart-define-from-file=prod.env
flutter build ios --dart-define-from-file=prod.env
```

---

## NAMING CONVENTIONS

| What | Convention | Example |
|------|-----------|---------|
| Package folder | `snake_case` | `dio_cart_repository` |
| Package name (pubspec) | `snake_case` | `dio_cart_repository` |
| Library file | `snake_case` | `{{project_name}}_core.dart` |
| Entity class | `PascalCase` + `Entity` suffix | `VendorEntity` |
| Repository interface | `PascalCase` + `Repository` suffix | `VendorRepository` |
| Dio implementation | `Dio` prefix + repo name | `DioVendorRepository` |
| Mock implementation | `Mock` prefix + repo name | `MockVendorRepository` |
| Dio model | `PascalCase` + `Model` suffix | `VendorModel` |
| Exception class | Entity + `RepositoryException` | `VendorRepositoryException` |
| Exception code enum | Entity + `ExceptionCode` | `VendorExceptionCode` |
| Feature folder | `snake_case` | `vendor/` |
| Page class | Feature + `Page` | `VendorPage` |
| Page wrapper | Feature + `PageWrapper` | `VendorPageWrapper` |
| Route class | Feature + `PageRoute` | `VendorPageRoute` |
| BLoC class | Feature + `Bloc` | `VendorBloc` |
| BLoC event | Feature + `Event` | `VendorLoadEvent` |
| BLoC state | Feature + `State` | `VendorState` |
| Presentation event | Feature + `PresentationEvent` | `VendorPresentationEvent` |
| App cubit | `App` + Name + `Cubit` | `AppLocaleCubit` |
| EventBus event | `App` + Name + `Event` | `AppLocaleUpdateEvent` |
| UI widget | Project + widget name | `{{Project}}Button` |
| Design token | `${{project_name}}Token` | `$eventiToken` |
| Env variable | `SCREAMING_SNAKE_CASE` | `CART_REPOSITORY_MODE` |
| Cache key | `camelCase` string literal | `'languageCode'` |
| Route path | `/kebab-case` | `/auth/login` |
| Route name | `kebab-case` | `'language-settings'` |

---

## FILE PATTERNS — AT A GLANCE

### Single-library + `part` (for tightly coupled packages)

Used by: `{{project_name}}_core`, `{{project_name}}_ui`

```dart
// barrel.dart
library;
part 'src/file_a.dart';
part 'src/file_b.dart';

// file_a.dart
part of 'barrel.dart';
```

### Standard `export` (for loosely coupled packages)

Used by: `mock_data`, all repository packages, feature barrels

```dart
// barrel.dart
export 'src/file_a.dart';
export 'src/file_b.dart';
```

### Route files as `part of` central registry

Used by: all feature route files

```dart
// feature_page_route.dart
part of '../../../../core/routing/app_routes.dart';

// app_routes.dart
part '../../features/auth/pages/login/login_page_route.dart';
part 'app_routes.g.dart';
```

### BLoC files with `part`

Used by: all feature BLoCs

```dart
// feature_bloc.dart
part 'feature_event.dart';
part 'feature_state.dart';

// feature_event.dart
part of 'feature_bloc.dart';
```

---

## END OF PRODUCTION BLUEPRINT

All 4 parts:

- **Part 1** (`PRODUCTION_BLUEPRINT.md`): Patterns 1–5 (Workspace, Core, HTTP Client, Dio Repos, Mock Repos)
- **Part 2** (`PRODUCTION_BLUEPRINT_PART2.md`): Patterns 6–8 (Cache Repo, Mock Data, UI Kit)
- **Part 3** (`PRODUCTION_BLUEPRINT_PART3.md`): Patterns 9–10 (App Shell, Feature Modules)
- **Part 4** (`PRODUCTION_BLUEPRINT_PART4.md`): Master Build Order + Quick-Action Checklists
