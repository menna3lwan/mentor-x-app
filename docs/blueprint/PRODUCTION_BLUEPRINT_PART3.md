# PRODUCTION BLUEPRINT — Part 3: Patterns 9–10

---

## PATTERN 9: APP SHELL (`{{project_name}}/`)

The main Flutter application. It owns:

- Environment configuration (`dev.env`, `Env` class)
- Initialization pipeline (`main.dart`, `{{Project}}Requirements`)
- Repository wiring (`RepositoriesFactory` — mock/prod switch)
- Global state wiring (`BlocsFactory` — app-level cubits)
- Cross-feature communication (`EventBus`, global events)
- Navigation (`GoRouter`, `StatefulShellRoute`)
- Widget composition tree (`{{Project}}` root widget)
- Feature modules (`lib/features/`)

### 9.1 Package structure

```
{{project_name}}/
├── pubspec.yaml
├── dev.env                     # Compile-time environment variables
├── build.yaml                  # Code generation config
├── makefile                    # Developer commands
├── lib/
│   ├── main.dart               # Entry point
│   ├── app/
│   │   ├── app.dart            # Barrel
│   │   ├── {{project_name}}.dart        # Root widget
│   │   ├── {{project_name}}_requirements.dart  # Initialization pipeline
│   │   └── initializers/
│   │       ├── initializers.dart          # Barrel
│   │       ├── repositories_factory.dart  # Mock/prod wiring
│   │       └── blocs_factory.dart         # Cubit initialization
│   ├── core/
│   │   ├── core.dart                      # Barrel
│   │   ├── utils/
│   │   │   ├── utils.dart                 # Barrel
│   │   │   ├── env.dart                   # Environment constants
│   │   │   ├── extensions/
│   │   │   │   └── navigation_extensions.dart
│   │   │   └── input_formatters/
│   │   │       ├── phone_number_formatter.dart
│   │   │       └── plus_symbol_filter_formatter.dart
│   │   ├── routing/
│   │   │   ├── routing.dart               # Barrel
│   │   │   ├── app_router.dart            # GoRouter setup
│   │   │   ├── app_routes.dart            # Central route file (all feature routes are `part` of this)
│   │   │   └── app_routes.g.dart          # Generated
│   │   ├── events/
│   │   │   ├── events.dart                # Barrel
│   │   │   └── app_global_events.dart     # EventBus event classes
│   │   ├── widgets/
│   │   │   ├── widgets.dart               # Barrel
│   │   │   └── app_refresh_listener.dart  # EventBus-driven refresh
│   │   └── blocs/
│   │       ├── blocs.dart                 # Barrel
│   │       ├── app_locale_cubit/
│   │       │   ├── app_locale_cubit.dart
│   │       │   ├── app_locale_events.dart
│   │       │   └── app_locale_listener.dart
│   │       ├── app_authentication_cubit/
│   │       │   ├── app_authentication_cubit.dart
│   │       │   ├── app_authentication_events.dart
│   │       │   └── app_authentication_listener.dart
│   │       ├── app_brightness_cubit/
│   │       │   ├── app_brightness_cubit.dart
│   │       │   ├── app_brightness_events.dart
│   │       │   └── app_brightness_listener.dart
│   │       ├── app_location_cubit/
│   │       │   ├── app_location_cubit.dart
│   │       │   ├── app_location_events.dart
│   │       │   └── app_location_listener.dart
│   │       ├── app_events_cubit/
│   │       │   ├── app_events_cubit.dart
│   │       │   ├── app_events_events.dart
│   │       │   └── app_events_state.dart
│   │       ├── app_notifications_cubit/
│   │       │   ├── app_notifications_cubit.dart
│   │       │   └── app_notifications_state.dart
│   │       └── app_navigation_cubit/
│   │           ├── app_navigation_cubit.dart
│   │           └── app_navigation_state.dart
│   └── features/
│       ├── features.dart                  # Barrel (exports all features)
│       ├── auth/
│       ├── home/
│       ├── vendor/
│       ├── cart/
│       ├── categories/
│       ├── profile/
│       ├── onboarding/
│       ├── settings/
│       ├── notifications/
│       ├── events/
│       ├── favorites/
│       └── assistance/
```

### 9.2 `dev.env` — Environment configuration

```env
# App Configuration
DEFAULT_LANGUAGE_CODE=en
DEFAULT_OTP_CODE_LENGTH=6
MIN_PHONE_NUMBER_LENGTH=11
MAX_PHONE_NUMBER_LENGTH=13

# API Configuration
{{PROJECT_UPPER}}_API_BASE_URL="https://your-api-url.com/dev"
{{PROJECT_UPPER}}_API_KEY="your-api-key"

# External Services
GOOGLE_MAPS_BASE_URL="https://places.googleapis.com/v1"
GOOGLE_MAPS_API_KEY="your-google-maps-key"

# Repositories modes (enum): MOCK, PROD
AUTHENTICATION_REPOSITORY_MODE=PROD
CART_REPOSITORY_MODE=MOCK
CATEGORY_REPOSITORY_MODE=MOCK
CONSULTATION_REPOSITORY_MODE=MOCK
EVENT_REPOSITORY_MODE=PROD
FAVORITES_REPOSITORY_MODE=MOCK
LOCATION_REPOSITORY_MODE=PROD
NOTIFICATIONS_REPOSITORY_MODE=PROD
PAYMENT_METHOD_REPOSITORY_MODE=MOCK
VENDOR_REPOSITORY_MODE=MOCK
SERVICE_REPOSITORY_MODE=PROD
OCCASIONS_REPOSITORY_MODE=MOCK

# Global Mock Caching Strategy: inMemory, secureStorage
MOCK_CACHING_STRATEGY=inMemory

# Mock values
MOCK_DELAY_IN_SECONDS=2
MOCK_USER_PHONE_NUMBER=01000000000
MOCK_OTP_CODE=123456
MOCK_USER_NAME="John Doe"
```

**How it works**: Run with `flutter run --dart-define-from-file=dev.env`. Each key becomes a compile-time constant accessible via `const String.fromEnvironment('KEY')`.

### 9.3 `Env` class — Compile-time constants

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:mock_data/mock_data.dart';

enum RepositoryMode {
  mock,
  prod;

  static RepositoryMode fromString(String value) {
    for (final mode in values) {
      if (mode.name == value.toLowerCase()) return mode;
    }
    throw Exception('Unknown repository mode: $value');
  }
}

final class Env {
  Env._();

  // ──── Application Constants ────
  static const defaultLanguageCode = String.fromEnvironment(
    'DEFAULT_LANGUAGE_CODE', defaultValue: 'en',
  );
  static const defaultOtpCodeLength = int.fromEnvironment(
    'DEFAULT_OTP_CODE_LENGTH', defaultValue: 6,
  );
  static const minPhoneNumberLength = int.fromEnvironment(
    'MIN_PHONE_NUMBER_LENGTH', defaultValue: 11,
  );
  static const maxPhoneNumberLength = int.fromEnvironment(
    'MAX_PHONE_NUMBER_LENGTH', defaultValue: 13,
  );

  // ──── API Configuration ────
  static const String {{project_name}}BaseUrl = String.fromEnvironment(
    '{{PROJECT_UPPER}}_API_BASE_URL',
  );
  static const String {{project_name}}ApiKey = String.fromEnvironment(
    '{{PROJECT_UPPER}}_API_KEY',
  );
  static const String googleMapsBaseUrl = String.fromEnvironment(
    'GOOGLE_MAPS_BASE_URL',
  );
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
  );

  // ──── Per-Repository Mode Switches ────
  static final authenticationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment('AUTHENTICATION_REPOSITORY_MODE'),
  );
  static final cartRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment('CART_REPOSITORY_MODE'),
  );
  // ... one per repository ...
  // Template: static final {{repo}}RepositoryMode = RepositoryMode.fromString(
  //   const String.fromEnvironment('{{REPO_UPPER}}_REPOSITORY_MODE'),
  // );

  // ──── Per-Repository Caching Strategy ────
  // Falls back to global MOCK_CACHING_STRATEGY if repo-specific is empty
  static final defaultMockCachingStrategy = MockCachingStrategy.fromString(
    const String.fromEnvironment('MOCK_CACHING_STRATEGY', defaultValue: 'inMemory'),
  );

  static final categoryCachingStrategy = MockCachingStrategy.fromString(
    const String.fromEnvironment('CATEGORY_CACHING_STRATEGY', defaultValue: '').isEmpty
        ? const String.fromEnvironment('MOCK_CACHING_STRATEGY', defaultValue: 'inMemory')
        : const String.fromEnvironment('CATEGORY_CACHING_STRATEGY'),
  );
  // ... one per repository that supports caching ...

  // ──── Mock Configuration ────
  static const int _mockDelayDurationInSeconds = int.fromEnvironment(
    'MOCK_DELAY_IN_SECONDS', defaultValue: 2,
  );
  static Duration get mockDelayDuration =>
      const Duration(seconds: _mockDelayDurationInSeconds);

  static const String mockPhoneNumber = String.fromEnvironment('MOCK_USER_PHONE_NUMBER');
  static const String mockOTP = String.fromEnvironment('MOCK_OTP_CODE');
  static const String mockUserName = String.fromEnvironment('MOCK_USER_NAME');

  static UserEntity get mockUser => UserEntity(
    id: 'mockUserId',
    name: mockUserName,
    email: 'mock@email.com',
    phoneNumber: mockPhoneNumber,
    country: Country.{{defaultCountry}},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
```

**Key rule**: `const String.fromEnvironment` reads compile-time dart-define values. `static final` for derived values (like `RepositoryMode.fromString`), `static const` for raw primitives.

### 9.4 `main.dart` — Entry point

```dart
import 'package:{{project_name}}/app/{{project_name}}.dart';
import 'package:{{project_name}}/app/{{project_name}}_requirements.dart';
import 'package:flutter/material.dart';

void main() async {
  // Start stopwatch to track initialization time
  final stopwatch = Stopwatch()..start();

  // Initialize app requirements
  final requirements = await {{Project}}Requirements.initialize();

  // Ensure splash screen displays for at least 2 seconds
  final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
  const minSplashDurationMs = 2000;
  if (elapsedMilliseconds < minSplashDurationMs) {
    final remainingTimeMs = minSplashDurationMs - elapsedMilliseconds;
    await Future.delayed(Duration(milliseconds: remainingTimeMs));
  }

  runApp({{Project}}(requirements: requirements));
}
```

**Splash timing**: The native splash screen (from `flutter_native_splash`) stays visible during `WidgetsFlutterBinding.ensureInitialized()` + `{{Project}}Requirements.initialize()`. The stopwatch ensures a minimum display time.

### 9.5 `{{Project}}Requirements` — Initialization pipeline

```dart
import 'dart:ui';

import 'package:{{project_name}}/app/{{project_name}}.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:{{project_name}}_ui/{{project_name}}_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
import 'initializers/initializers.dart';

final class {{Project}}Requirements {
  final Locale locale;
  final Brightness brightness;
  final List<LocalizedClient> localizedClients;
  final AppBlocs blocs;
  final AppRepositories repositories;
  final RouterConfig<Object> routerConfig;

  static final {{Project}}Logger _logger = {{Project}}Logger('{{Project}}Requirements');

  {{Project}}Requirements({
    required this.blocs,
    required this.locale,
    required this.brightness,
    required this.repositories,
    required this.routerConfig,
    required this.localizedClients,
  });

  static Future<{{Project}}Requirements> initialize() async {
    {{Project}}Logger.enabled = kDebugMode;
    await _initSystemUIStyle();
    _initLocalizationSettings();

    // 1. Initialize all repositories (parallel)
    final (:repositories, :localizedClients) =
        await RepositoriesFactory.initRepositories();
    final languageCode = RepositoriesFactory.initialLanguageCode;

    // 2. Load brightness from cache (or use device default)
    final initialBrightness = await _initBrightness(repositories.cacheRepository);
    _logger.info('Initializing with language $languageCode, brightness $initialBrightness');
    await LocaleSettings.setLocaleRaw(languageCode);

    // 3. Load cached user
    UserEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
    } catch (e, s) {
      _logger.error('Failed to get cached user: ', e, s);
    }

    // 4. Initialize all app-level cubits
    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      brightness: initialBrightness,
      cacheRepository: repositories.cacheRepository,
      locationRepository: repositories.locationRepository,
    );

    // 5. Non-blocking: load initial data for logged-in users
    if (user != null) {
      _loadInitialIncomingEvents(
        appEventsCubit: blocs.appEventsCubit,
        eventRepository: repositories.eventRepository,
      ).ignore();
      _loadInitialIncomingNotifications(
        appNotificationsCubit: blocs.appNotificationsCubit,
        notificationRepository: repositories.notificationRepository,
      ).ignore();
    }

    // 6. Determine initial route
    final String initialRoute = await _determineTheInitialRoute(
      user: user,
      cacheRepository: repositories.cacheRepository,
    );

    // 7. Create router
    final AppRouter appRouter = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
    );

    return {{Project}}Requirements(
      blocs: blocs,
      repositories: repositories,
      locale: Locale(languageCode),
      brightness: initialBrightness,
      routerConfig: appRouter.routes,
      localizedClients: localizedClients,
    );
  }

  static Future<Brightness> _initBrightness(CacheRepository cacheRepository) async {
    final String? brightness = await cacheRepository.get(CacheKeys.brightness);
    final deviceBrightness = PlatformDispatcher.instance.platformBrightness;
    return (brightness == null)
        ? deviceBrightness
        : [Brightness.light.name, Brightness.dark.name].contains(brightness)
            ? Brightness.values.byName(brightness)
            : deviceBrightness;
  }

  static Future<void> _initSystemUIStyle() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,
    ]).ignore();
    if ({{Project}}PlatformChecker.isIOS) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top],
      ).ignore();
    }
  }

  static Future<String> _determineTheInitialRoute({
    required CacheRepository cacheRepository,
    required UserEntity? user,
  }) async {
    final String? cachedFirstTimeOpened =
        await cacheRepository.get(CacheKeys.isFirstTimeOpened);
    final bool isFirstTimeOpened =
        (cachedFirstTimeOpened ?? 'true') == true.toString();
    if (isFirstTimeOpened) {
      return const InitialLanguagePageRoute().location;
    } else {
      return const HomePageRoute().location;
    }
  }

  static Future<void> _loadInitialIncomingEvents({
    required EventRepository eventRepository,
    required AppEventsCubit appEventsCubit,
  }) async {
    try {
      final upcomingEvents = await eventRepository.getUpcomingEvents();
      final currentPastEvents = appEventsCubit.state.pastEvents;
      appEventBus.fire(AppEventsUpdateEvent(
        upcomingEvents: upcomingEvents,
        pastEvents: currentPastEvents,
      ));
    } catch (e, s) {
      _logger.error('Failed to load initial upcoming events: ', e, s);
    }
  }

  static Future<void> _loadInitialIncomingNotifications({
    required NotificationRepository notificationRepository,
    required AppNotificationsCubit appNotificationsCubit,
  }) async {
    try {
      final newNotifications = await notificationRepository.getNewNotifications();
      appNotificationsCubit.setAllNotifications(
        newNotifications: newNotifications.$1,
        earlierNotifications: [],
      );
    } catch (e, s) {
      _logger.error('Failed to load initial notifications: ', e, s);
    }
  }

  static void _initLocalizationSettings() {
    // Arabic plural resolver
    LocaleSettings.setPluralResolver(
      locale: AppLocale.ar,
      cardinalResolver: (n, {few, many, one, other, two, zero}) {
        if (n == 0 && zero != null) return zero;
        if (n == 1 && one != null) return one;
        if (n == 2) return two ?? other!;
        if (n >= 3) return other!;
        return other!;
      },
    );
  }
}
```

**Initialization order is critical**:

1. System UI chrome
2. Localization plural resolvers
3. Repositories (parallel `Future.wait`)
4. Language code (from cache or device)
5. Brightness (from cache or device)
6. Cached user
7. App-level cubits (depend on repos + user)
8. Non-blocking data loads (events, notifications) — `.ignore()` = fire-and-forget
9. Initial route determination
10. Router creation

### 9.6 `RepositoriesFactory` — The mock/prod switch

```dart
import 'package:dio_authentication_repository/dio_authentication_repository.dart';
import 'package:dio_cart_repository/dio_cart_repository.dart';
// ... all dio_* and mock_* imports ...
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:mock_data/mock_data.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';

import '../../core/utils/env.dart';

final class AppRepositories {
  final CacheRepository cacheRepository;
  final AuthenticationRepository authenticationRepository;
  final CartRepository cartRepository;
  // ... all repositories as final fields ...

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
    required this.cartRepository,
    // ... required all ...
  });

  /// Convert to a list for iteration
  List<Object> toList() => [cacheRepository, authenticationRepository, cartRepository, /* ... */];

  /// Convert to BlocProvider list for MultiRepositoryProvider
  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<AuthenticationRepository>(create: (_) => authenticationRepository),
      RepositoryProvider<CartRepository>(create: (_) => cartRepository),
      // ... one per repository ...
    ];
  }
}

final class RepositoriesFactory {
  RepositoriesFactory._();

  // ──── Singleton instances ────
  static HttpClient? _httpClient;
  static bool isHttpClientInitialized = false;
  static late final String initialLanguageCode;
  static CacheRepository? _cacheRepository;
  static MockLocalizedClient? _mockLocalizedClient;

  // ──── Lazy singleton initializers ────

  static Future<CacheRepository> _initCacheRepository() async {
    if (_cacheRepository != null) return _cacheRepository!;
    final CacheRepository repo = FlutterSecureStorageCacheRepository();
    await repo.initialize();
    _cacheRepository = repo;
    return repo;
  }

  static MockLocalizedClient _initMockLocalizedClient() {
    if (_mockLocalizedClient != null) return _mockLocalizedClient!;
    _mockLocalizedClient = MockLocalizedClient(languageCode: initialLanguageCode);
    return _mockLocalizedClient!;
  }

  static Future<HttpClient> _initHttpClient() async {
    if (isHttpClientInitialized && _httpClient != null) return _httpClient!;
    final cacheRepository = await _initCacheRepository();
    final httpClient = DioHttpClient(
      apiKey: Env.{{project_name}}ApiKey,
      baseUrl: Env.{{project_name}}BaseUrl,
      cacheRepository: cacheRepository,
      languageCode: initialLanguageCode,
    );
    _httpClient = httpClient;
    isHttpClientInitialized = true;
    return httpClient;
  }

  // ──── Per-repository initializers ────
  // EVERY repository follows this exact pattern:

  static Future<{{Entity}}Repository> _init{{Entity}}Repository() async {
    late final {{Entity}}Repository repo;
    switch (Env.{{entity}}RepositoryMode) {
      case RepositoryMode.mock:
        final localizedClient = _initMockLocalizedClient();
        final cacheRepository = await _initCacheRepository();
        repo = Mock{{Entity}}Repository(
          delay: Env.mockDelayDuration,
          localizedClient: localizedClient,
          cacheRepository: cacheRepository,
          cachingStrategy: Env.{{entity}}CachingStrategy,
        );
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        final cacheRepository = await _initCacheRepository();
        repo = Dio{{Entity}}Repository(
          httpClient: httpClient,
          cacheRepository: cacheRepository,
        );
    }
    await repo.initialize();
    return repo;
  }
  // Not all repositories need localizedClient or cacheRepository.
  // Only include what the specific mock/prod implementation requires.

  // ──── Default language detection ────

  static String _defaultLanguageCode() {
    final deviceLanguageCode = PlatformDispatcher.instance.locale.languageCode;
    final supportedLocales = LocaleSettings.instance.supportedLocalesRaw;
    return supportedLocales.contains(deviceLanguageCode)
        ? deviceLanguageCode
        : supportedLocales.contains(Env.defaultLanguageCode)
            ? Env.defaultLanguageCode
            : supportedLocales.first;
  }

  // ──── Main entry point ────

  static Future<({AppRepositories repositories, List<LocalizedClient> localizedClients})>
  initRepositories() async {
    // Cache repo MUST be initialized first (others may depend on it)
    final CacheRepository cacheRepository = await _initCacheRepository();

    // Language code from cache or device default
    initialLanguageCode =
        await cacheRepository.get(CacheKeys.languageCode) ?? _defaultLanguageCode();

    // ★ PARALLEL INITIALIZATION ★
    final [
      authenticationRepository as AuthenticationRepository,
      cartRepository as CartRepository,
      // ... destructure all ...
    ] = await Future.wait([
      _initAuthenticationRepository(),
      _initCartRepository(),
      // ... all repo initializers ...
    ]);

    final repos = AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: authenticationRepository,
      cartRepository: cartRepository,
      // ... all ...
    );

    // Build localized clients list
    final HttpClient httpClient = await _initHttpClient();
    final List<LocalizedClient> localizedClients = [httpClient];
    if (_mockLocalizedClient != null) {
      localizedClients.add(_mockLocalizedClient!);
    }

    return (repositories: repos, localizedClients: localizedClients);
  }
}
```

**Factory rules**:

- Cache repository initializes FIRST (others depend on it)
- `Future.wait` parallelizes ALL repo initializations
- Dart 3 list destructuring (`final [...] = await Future.wait(...)`) maps results to typed variables
- `MockLocalizedClient` is created lazily only if any mock repo uses it
- `HttpClient` is created lazily only if any prod repo uses it
- Return type is a **named record** `({AppRepositories, List<LocalizedClient>})`

### 9.7 `BlocsFactory` — App-level cubit initialization

```dart
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import '../../core/core.dart';

final class AppBlocs {
  final AppLocaleCubit appLocaleCubit;
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppBrightnessCubit appBrightnessCubit;
  final AppLocationCubit appLocationCubit;
  final AppEventsCubit appEventsCubit;
  final AppNotificationsCubit appNotificationsCubit;
  final AppNavigationCubit appNavigationCubit;

  const AppBlocs._({
    required this.appLocaleCubit,
    required this.appAuthenticationCubit,
    required this.appBrightnessCubit,
    required this.appLocationCubit,
    required this.appEventsCubit,
    required this.appNotificationsCubit,
    required this.appNavigationCubit,
  });

  /// Converts to BlocProvider list for MultiBlocProvider
  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppLocaleCubit>.value(value: appLocaleCubit),
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
      BlocProvider<AppBrightnessCubit>.value(value: appBrightnessCubit),
      BlocProvider<AppLocationCubit>.value(value: appLocationCubit),
      BlocProvider<AppEventsCubit>.value(value: appEventsCubit),
      BlocProvider<AppNotificationsCubit>.value(value: appNotificationsCubit),
      BlocProvider<AppNavigationCubit>.value(value: appNavigationCubit),
    ];
  }
}

final class BlocsFactory {
  BlocsFactory._();

  static Future<AppBlocs> initBlocs({
    required UserEntity? user,
    required String languageCode,
    required Brightness brightness,
    required CacheRepository cacheRepository,
    required LocationRepository locationRepository,
  }) async {
    final localizationCubit = AppLocaleCubit(
      initialLanguageCode: languageCode,
      cacheRepository: cacheRepository,
    );
    final authenticationCubit = AppAuthenticationCubit(initialUser: user);
    final brightnessCubit = AppBrightnessCubit(initialBrightness: brightness);

    final initialLocation = await _loadInitialUserLocation(cacheRepository);
    final locationCubit = AppLocationCubit(
      cacheRepository: cacheRepository,
      locationRepository: locationRepository,
      initialLocation: initialLocation,
    );
    final eventsCubit = AppEventsCubit();
    final notificationsCubit = AppNotificationsCubit();
    final navigationCubit = AppNavigationCubit();

    return AppBlocs._(
      appLocaleCubit: localizationCubit,
      appAuthenticationCubit: authenticationCubit,
      appBrightnessCubit: brightnessCubit,
      appLocationCubit: locationCubit,
      appEventsCubit: eventsCubit,
      appNotificationsCubit: notificationsCubit,
      appNavigationCubit: navigationCubit,
    );
  }

  static Future<LocationEntity?> _loadInitialUserLocation(
    CacheRepository cacheRepository,
  ) async {
    try {
      final cachedLocationJson = await cacheRepository.get(CacheKeys.userLocation);
      if (cachedLocationJson != null) {
        return LocationEntity.fromJson(
          jsonDecode(cachedLocationJson) as Map<String, dynamic>,
        );
      }
    } catch (_) {}
    return LocationEntity.defaultLocation;
  }
}
```

### 9.8 Root widget — `{{Project}}`

```dart
import 'package:event_bus/event_bus.dart';
import 'package:{{project_name}}_ui/{{project_name}}_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '{{project_name}}_requirements.dart';

/// Global singletons (accessible from anywhere in the app)
final EventBus appEventBus = EventBus();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final class {{Project}} extends StatelessWidget {
  final {{Project}}Requirements requirements;

  const {{Project}}({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    final darkMixTheme = {{Project}}Themes.dark;
    final lightMixTheme = {{Project}}Themes.light;

    return MultiRepositoryProvider(
      providers: requirements.repositories.toProviders(),
      child: MultiBlocProvider(
        providers: requirements.blocs.toProviders(),
        child: {{Project}}TranslationProvider(
          child: Builder(
            builder: (context) {
              final brightness = Brightness.light; // or context.watch<AppBrightnessCubit>().state;
              return {{Project}}ThemeProvider(
                brightness: brightness,
                darkTheme: darkMixTheme,
                lightTheme: lightMixTheme,
                child: {{Project}}SkeletonProvider(
                  child: Builder(
                    builder: (context) {
                      // Force rebuild on locale change
                      final String currentLanguageCode =
                          TranslationProvider.of(context).flutterLocale.languageCode;
                      final appKey = ValueKey(currentLanguageCode);

                      // Update all localized clients when language changes
                      for (final client in requirements.localizedClients) {
                        client.updateLanguageCode(currentLanguageCode);
                      }

                      return MaterialApp.router(
                        key: appKey,
                        debugShowCheckedModeBanner: false,
                        routerConfig: requirements.routerConfig,
                        themeMode: ThemeMode.values[brightness.index],
                        locale: TranslationProvider.of(context).flutterLocale,
                        supportedLocales: LocaleSettings.instance.supportedLocales,
                        localizationsDelegates: GlobalMaterialLocalizations.delegates,
                        theme: {{Project}}Themes.materialThemeDataFromTheme(
                          lightMixTheme, context, Brightness.light,
                        ),
                        darkTheme: {{Project}}Themes.materialThemeDataFromTheme(
                          darkMixTheme, context, Brightness.dark,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

**Widget tree** (from outermost to innermost):

1. `MultiRepositoryProvider` — 13 repos available via `context.read<XRepository>()`
2. `MultiBlocProvider` — 7 app-level cubits available via `context.read<XCubit>()`
3. `{{Project}}TranslationProvider` — slang `TranslationProvider` wrapper
4. `Builder` — reads brightness cubit
5. `{{Project}}ThemeProvider` — wraps `MixTheme` with light/dark data
6. `{{Project}}SkeletonProvider` — `Skeletonizer` config
7. `Builder` — locale-keyed rebuild + localized client update
8. `MaterialApp.router` — GoRouter navigation, Material theme bridge

**Force rebuild on locale change**: `key: ValueKey(currentLanguageCode)` causes the entire `MaterialApp` to rebuild when the user switches language. The `for (final client in requirements.localizedClients)` loop updates both the Dio HTTP client and MockLocalizedClient language codes.

### 9.9 `AppRouter` — GoRouter setup

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

final class AppRouter {
  final String? initialLocation;

  AppRouter({
    this.initialLocation,
    bool debugLogDiagnostics = false,
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    _goRouter = _routes(navigatorKey, debugLogDiagnostics);
  }

  late final GoRouter _goRouter;
  GoRouter get routes => _goRouter;

  GoRouter _routes(GlobalKey<NavigatorState> navigatorKey, bool debugLogDiagnostics) {
    return GoRouter(
      routes: $appRoutes,        // Generated from app_routes.dart annotations
      navigatorKey: navigatorKey, // rootNavigatorKey for modal navigation
      initialLocation: initialLocation,
      debugLogDiagnostics: debugLogDiagnostics,
    );
  }
}
```

### 9.10 `app_routes.dart` — Central route registration

```dart
import 'dart:async';

import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:{{project_name}}_ui/{{project_name}}_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import '../core.dart';

// ★ Feature route files are `part of` this file ★
part '../../features/auth/pages/login/login_page_route.dart';
part '../../features/auth/pages/otp/otp_page_route.dart';
part '../../features/home/pages/home/home_page_route.dart';
part '../../features/home/pages/home/main_page_route.dart';
part '../../features/cart/pages/cart/cart_page_route.dart';
part '../../features/vendor/pages/vendor/vendor_page_route.dart';
part '../../features/categories/pages/categories/categories_page_route.dart';
part '../../features/profile/pages/profile/profile_page_route.dart';
part '../../features/settings/pages/settings/settings_page_route.dart';
part '../../features/onboarding/pages/initial_language/initial_language_page_route.dart';
// ... one part per route file ...
part 'app_routes.g.dart';  // Generated code
```

**Route registration rule**: Every feature's `*_page_route.dart` uses `part of '../../../../core/routing/app_routes.dart'`. This gives route files access to all imports from `app_routes.dart` without their own import statements.

### 9.11 EventBus — Cross-feature communication

```dart
// core/events/app_global_events.dart

final class AppGlobalEvent {
  const AppGlobalEvent();
}

/// Fired when language changes or auth state changes — features should refresh
final class AppRefreshEvent extends AppGlobalEvent {
  const AppRefreshEvent();
}

/// Fired after successful OTP — post-login navigation callback should execute
final class AppPostLoginNavigationEvent extends AppGlobalEvent {
  const AppPostLoginNavigationEvent();
}
```

**Event flow**:

- **Feature → App cubits**: Features fire events via `appEventBus.fire(SomeEvent())`
- **App cubits listen**: Each cubit subscribes to its relevant event type in its constructor
- **Broadcast**: `AppRefreshEvent` is the universal "reload your data" signal
- **One-time actions**: `AppPostLoginNavigationEvent` triggers post-login redirect

### 9.12 `AppRefreshListener` — Reactive widget

```dart
import 'dart:async';
import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../../core/core.dart';

final class AppRefreshListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;

  const AppRefreshListener({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<AppRefreshListener> createState() => _AppRefreshListenerState();
}

final class _AppRefreshListenerState extends State<AppRefreshListener> {
  late final StreamSubscription<AppRefreshEvent> _appRefreshSubscription;

  @override
  void initState() {
    super.initState();
    _appRefreshSubscription = appEventBus.on<AppRefreshEvent>().listen((event) {
      widget.onRefresh();
    });
  }

  @override
  void dispose() {
    _appRefreshSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
```

**Usage in features**: Wrap page wrappers with `AppRefreshListener(onRefresh: () => bloc.add(ReloadEvent()), child: ...)` to reload data when language or auth state changes.

### 9.13 App-level cubit template (EventBus-driven)

Every app-level cubit follows this pattern:

```
app_{{name}}_cubit/
├── app_{{name}}_cubit.dart    # Cubit with EventBus subscription
├── app_{{name}}_events.dart   # Equatable events for EventBus
├── app_{{name}}_listener.dart # BlocBuilder widget (optional)
└── app_{{name}}_state.dart    # State class (part of cubit if Equatable, or inline)
```

**Cubit template**:

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:{{project_name}}/app/{{project_name}}.dart';
import '../../events/app_global_events.dart';
import 'app_{{name}}_events.dart';

export 'app_{{name}}_events.dart';
export 'app_{{name}}_listener.dart';

final class App{{Name}}Cubit extends Cubit<{{StateType}}> {
  final EventBus eventBus;
  late final StreamSubscription _subscription;

  App{{Name}}Cubit({
    required {{StateType}} initialState,
    EventBus? eventBus,
    // ... any dependencies ...
  }) : eventBus = eventBus ?? appEventBus,
       super(initialState) {
    _subscription = this.eventBus.on<App{{Name}}Event>().listen((event) {
      if (event is App{{Name}}UpdateEvent) {
        // Handle update
        emit(/* new state */);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
```

**Events template**:

```dart
import 'package:equatable/equatable.dart';

sealed class App{{Name}}Event extends Equatable {
  @override
  List<Object?> get props => [];
}

final class App{{Name}}UpdateEvent extends App{{Name}}Event {
  final {{DataType}} data;

  App{{Name}}UpdateEvent({required this.data});

  @override
  List<Object?> get props => [...super.props, data];
}
```

**Listener template**:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_{{name}}_cubit.dart';

class App{{Name}}Listener extends StatelessWidget {
  final Widget Function(BuildContext context, {{StateType}} state) builder;

  const App{{Name}}Listener({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<App{{Name}}Cubit, {{StateType}}>(builder: builder);
  }
}
```

### 9.14 `build.yaml` (app)

```yaml
targets:
  $default:
    builders:
      go_router_builder:
        enabled: true
      # All other builders disabled — only go_router_builder in the main app
```

### 9.15 `makefile`

```makefile
update_localization:
 cd ../packages/{{project_name}}_ui && dart run slang

generate:
 dart run build_runner build --delete-conflicting-outputs

clean_and_get:
 flutter clean && flutter pub get
```

---

## PATTERN 10: FEATURE MODULES (`features/`)

Each feature lives in its own self-contained folder under `lib/features/`. Features share NO imports with each other — they communicate only through:

- App-level cubits (via `context.read<XCubit>()`)
- EventBus events (via `appEventBus.fire(...)`)
- Repository interfaces (via `context.read<XRepository>()`)

### 10.1 Feature folder structure

```
features/{{feature_name}}/
├── {{feature_name}}.dart           # Barrel: exports pages/pages.dart
├── pages/
│   ├── pages.dart                  # Barrel: exports all page barrels
│   └── {{page_name}}/
│       ├── {{page_name}}.dart                  # Page barrel
│       ├── {{page_name}}_page.dart             # Pure UI (accepts widget slots)
│       ├── {{page_name}}_page_route.dart       # Route + BlocProvider (part of app_routes)
│       ├── {{page_name}}_page_wrapper.dart     # Wires BLoC → Page via BlocBuilder
│       ├── bloc/
│       │   ├── {{page_name}}_bloc.dart         # Business logic
│       │   ├── {{page_name}}_event.dart        # Bloc events (part of bloc)
│       │   └── {{page_name}}_state.dart        # Bloc state (part of bloc)
│       └── widgets/
│           ├── widgets.dart                     # Barrel
│           ├── {{widget_name}}/
│           │   ├── {{widget_name}}.dart         # Barrel + pure UI
│           │   └── {{widget_name}}_wrapper.dart # BlocBuilder → UI
│           └── ...
```

### 10.2 `*_page_route.dart` — Route + BlocProvider

This file is `part of` the central route registry:

```dart
part of '../../../../core/routing/app_routes.dart';

/// Branch data for StatefulShellRoute (only for top-level tabs)
final class {{Feature}}PageRouteBranchData extends StatefulShellBranchData {}

@TypedGoRoute<{{Feature}}PageRoute>(path: '/{{feature-path}}', name: '{{feature-name}}')
final class {{Feature}}PageRoute extends GoRouteData with ${{Feature}}PageRoute {
  const {{Feature}}PageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<{{Feature}}Bloc>(
      create: (context) {
        // Read repositories from the provider tree
        final repository = context.read<{{Entity}}Repository>();
        // Optionally read app-level state
        final user = context.read<AppAuthenticationCubit>().state;
        return {{Feature}}Bloc(
          repository: repository,
          user: user,
        )..add(const {{Feature}}LoadEvent());
      },
      child: const {{Feature}}PageWrapper(),
    );
  }
}
```

**Route rules**:

- File header: `part of '../../../../core/routing/app_routes.dart';`
- Annotation: `@TypedGoRoute<RouteName>(path: '/path', name: 'name')`
- Mixin: `GoRouteData with $RouteName` (generated)
- `build()` creates the feature's BlocProvider and dispatches initial load event
- Child is ALWAYS the wrapper, never the page directly

**Routes with parameters**:

```dart
final class VendorPageRoute extends GoRouteData with $VendorPageRoute {
  final String vendorId;

  const VendorPageRoute({required this.vendorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // Extra data passed via state.extra
    final vendor = state.extra as VendorEntity?;
    return BlocProvider(
      create: (context) {
        return VendorBloc(vendorRepository: context.read<VendorRepository>())
          ..add(VendorLoadEvent(vendorId: vendorId, initialVendor: vendor));
      },
      child: const VendorPageWrapper(),
    );
  }
}
```

### 10.3 `*_page.dart` — Pure UI (slot-based)

The page is a **pure layout widget**. It knows NOTHING about BLoC, repositories, or state management. It accepts widget slots:

```dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final class {{Feature}}Page extends StatelessWidget {
  final Widget appBar;
  final Widget header;
  final Widget content;
  final Widget? footer;

  const {{Feature}}Page({
    super.key,
    required this.appBar,
    required this.header,
    required this.content,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
                    const Gap(16),
                    content,
                  ],
                ),
              ),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}
```

**Why slots**: The page is testable in isolation (pass any widget). The wrapper decides which concrete widgets to inject.

### 10.4 `*_page_wrapper.dart` — BLoC → Page bridge

The wrapper reads BLoC state and maps it to the page's widget slots:

```dart
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';
import 'package:{{project_name}}_ui/{{project_name}}_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features.dart';

final class {{Feature}}PageWrapper extends StatefulWidget {
  const {{Feature}}PageWrapper({super.key});

  @override
  State<{{Feature}}PageWrapper> createState() => _{{Feature}}PageWrapperState();
}

class _{{Feature}}PageWrapperState extends State<{{Feature}}PageWrapper> {
  // Controllers and keys (owned by wrapper, not page)
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<{{Feature}}Bloc, {{Feature}}PresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case {{Feature}}NavigationPresentationEvent(:final route):
            route.push(context);
          case {{Feature}}FailurePresentationEvent(:final exception):
            exception.showAsToast();
        }
      },
      child: Builder(
        builder: (context) {
          // Use context.select for granular rebuilds
          final isLoading = context.select<{{Feature}}Bloc, bool>(
            (bloc) => bloc.state.isLoading,
          );
          final items = context.select<{{Feature}}Bloc, List<{{Entity}}Entity>>(
            (bloc) => bloc.state.items,
          );

          return {{Feature}}Page(
            appBar: const {{Feature}}AppBarWrapper(),
            header: const {{Feature}}HeaderWrapper(),
            content: {{Feature}}ContentWrapper(items: items, isLoading: isLoading),
            footer: {{Feature}}FooterWrapper(searchController: _searchController),
          );
        },
      ),
    );
  }
}
```

**Wrapper rules**:

- Owns mutable objects (controllers, keys, subscriptions)
- `BlocPresentationListener` handles one-time events (navigation, toasts)
- Uses `context.select` for granular rebuilds (NOT `BlocBuilder` for everything)
- Passes concrete widgets to the page's slots
- Sub-widgets have their own `_wrapper.dart` files for further decomposition

### 10.5 `bloc/` — Feature BLoC template

#### `{{feature}}_bloc.dart`

```dart
import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:{{project_name}}_core/{{project_name}}_core.dart';

part '{{feature}}_event.dart';
part '{{feature}}_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class {{Feature}}PresentationEvent {
  const {{Feature}}PresentationEvent();
}

final class {{Feature}}NavigationPresentationEvent extends {{Feature}}PresentationEvent {
  final GoRouteData route;
  const {{Feature}}NavigationPresentationEvent({required this.route});
}

final class {{Feature}}FailurePresentationEvent extends {{Feature}}PresentationEvent {
  final {{Project}}Exception exception;
  const {{Feature}}FailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class {{Feature}}Bloc extends Bloc<{{Feature}}Event, {{Feature}}State>
    with BlocPresentationMixin<{{Feature}}State, {{Feature}}PresentationEvent> {

  final {{Entity}}Repository _repository;
  final {{Project}}Logger _logger = {{Project}}Logger('{{Feature}}Bloc');

  {{Feature}}Bloc({
    required {{Entity}}Repository repository,
    {{Feature}}State initialState = {{Feature}}State.initial,
  }) : _repository = repository,
       super(initialState) {
    on<{{Feature}}LoadEvent>(_onLoad);
    on<{{Feature}}RefreshEvent>(_onRefresh);
  }

  Future<void> _onLoad({{Feature}}LoadEvent event, Emitter<{{Feature}}State> emit) async {
    try {
      emit(state.copyWith(loadingState: LoadingState.loading));
      final items = await _repository.getAll();
      emit(state.copyWith(
        items: items,
        loadingState: LoadingState.loaded,
      ));
    } catch (e, s) {
      _logger.error('Failed to load: ', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
      emitPresentation({{Feature}}FailurePresentationEvent(
        exception: e is {{Project}}Exception ? e : {{Project}}Exception.unknown(),
      ));
    }
  }
}
```

#### `{{feature}}_event.dart`

```dart
part of '{{feature}}_bloc.dart';

sealed class {{Feature}}Event extends Equatable {
  const {{Feature}}Event();
  @override
  List<Object?> get props => [];
}

final class {{Feature}}LoadEvent extends {{Feature}}Event {
  const {{Feature}}LoadEvent();
}

final class {{Feature}}RefreshEvent extends {{Feature}}Event {
  const {{Feature}}RefreshEvent();
}
```

#### `{{feature}}_state.dart`

```dart
part of '{{feature}}_bloc.dart';

enum LoadingState { initial, loading, loaded, error;
  bool get isLoading => this == LoadingState.loading;
  bool get isLoaded => this == LoadingState.loaded;
  bool get isError => this == LoadingState.error;
}

final class {{Feature}}State extends Equatable {
  final LoadingState loadingState;
  final List<{{Entity}}Entity> items;

  const {{Feature}}State({
    required this.loadingState,
    required this.items,
  });

  static const initial = {{Feature}}State(
    loadingState: LoadingState.initial,
    items: [],
  );

  @override
  List<Object?> get props => [loadingState, items];

  /// Use {{Project}}NullableValue<T> for nullable fields in copyWith
  {{Feature}}State copyWith({
    LoadingState? loadingState,
    List<{{Entity}}Entity>? items,
    {{Project}}NullableValue<String?>? optionalField,
  }) {
    return {{Feature}}State(
      loadingState: loadingState ?? this.loadingState,
      items: items ?? this.items,
    );
  }
}
```

**BLoC rules**:

- `extends Bloc<Event, State> with BlocPresentationMixin<State, PresentationEvent>`
- `BlocPresentationMixin` emits one-time events via `emitPresentation()` — unlike `emit()`, these don't re-fire on widget rebuild
- Events use `sealed class` hierarchy with `Equatable`
- State uses `Equatable` + `copyWith` pattern
- For nullable fields in `copyWith`, use `{{Project}}NullableValue<T>` wrapper
- `static const initial` for default state
- Error handling: `catch` → emit error state → `emitPresentation` for toast/navigation

### 10.6 Widget decomposition (`_wrapper` pattern)

Sub-widgets within a feature follow the same separation:

```
widgets/
├── widgets.dart                           # Barrel
├── {{feature}}_header/
│   ├── {{feature}}_header.dart            # Pure UI
│   └── {{feature}}_header_wrapper.dart    # BlocBuilder → UI
├── {{feature}}_content/
│   ├── {{feature}}_content.dart           # Pure UI
│   └── {{feature}}_content_wrapper.dart   # BlocBuilder → UI
```

**Widget wrapper template**:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features.dart';

final class {{Feature}}HeaderWrapper extends StatelessWidget {
  const {{Feature}}HeaderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.select for granular rebuild
    final title = context.select<{{Feature}}Bloc, String>(
      (bloc) => bloc.state.title,
    );
    return {{Feature}}Header(title: title);
  }
}
```

### 10.7 Auth-gating pattern

When a tab or action requires authentication, use `LoginPageBottomSheet.showWithNavigation`:

```dart
/// In a bottom nav item's onTap:
EventiBottomNavigationBarItem(
  index: 3,
  label: labels.cart,
  iconPath: icons.cartOutlineIcon,
  activeIconPath: icons.cartFilledIcon,
  onTap: (context, index) {
    if (LoginPageBottomSheet.shouldShow(context)) {
      // Not logged in — store navigation callback and show login
      LoginPageBottomSheet.showWithNavigation(
        context,
        navigationCallback: (ctx) => const CartPageRoute().go(ctx),
      );
    } else {
      // Logged in — navigate directly
      navigationShell.goBranch(index);
    }
  },
),
```

**Auth-gating flow**:

1. `LoginPageBottomSheet.shouldShow(context)` checks if `AppAuthenticationCubit.state == null`
2. If not logged in → `showWithNavigation()`:
   a. Stores callback in `AppNavigationCubit`
   b. Shows login bottom sheet
3. User completes login + OTP → `updateUserSync(user)` fires `AppRefreshEvent`
4. OTP success handler calls `consumeIntendedNavigation()` on `AppNavigationCubit`
5. The stored callback executes (e.g., `CartPageRoute().go(ctx)`)
6. If user dismisses login without completing, `dispose()` calls `clearIntendedNavigation()`

### 10.8 `LoginPageBottomSheet` — Dual-mode login

The same login UI works as both a **full-page route** and a **bottom sheet**:

```dart
final class LoginPageBottomSheet extends StatefulWidget {
  const LoginPageBottomSheet({super.key});

  /// Check if login sheet should show (user is not authenticated)
  static bool shouldShow(BuildContext context) {
    return context.read<AppAuthenticationCubit>().state == null;
  }

  /// Show login as a standalone bottom sheet
  static void show({required BuildContext context, VoidCallback? doElse}) {
    if (shouldShow(context)) {
      final sheet = BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository: context.read<AuthenticationRepository>(),
        ),
        child: const LoginPageBottomSheet(),
      );
      context.showBottomSheet(
        enableDrag: true,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) => sheet,
      );
    } else {
      doElse?.call();
    }
  }

  /// Show login with post-login navigation callback
  static void showWithNavigation(
    BuildContext context, {
    required NavigationCallback navigationCallback,
  }) {
    if (shouldShow(context)) {
      context.read<AppNavigationCubit>().setIntendedNavigation(
        callback: navigationCallback,
      );
      show(context: context);
    }
  }

  // ... (StatefulWidget build with form + OTP chaining)
}
```

**Key patterns**:

- `show()` for simple "require login" checks
- `showWithNavigation()` for "login then navigate to X"
- `shouldShow()` is the centralized auth check
- Bottom sheet creates its OWN `BlocProvider<LoginBloc>` — it's self-contained
- On OTP success, chains to `OtpPageBottomSheet` (another bottom sheet on top)
- `dispose()` cleans up `AppNavigationCubit` if login was abandoned

### 10.9 `StatefulShellRoute` — Main page shell

```dart
part of '../../../../core/routing/app_routes.dart';

@TypedStatefulShellRoute<MainPageRoute>(
  branches: [
    TypedStatefulShellBranch<HomePageRouteBranchData>(
      routes: [
        TypedGoRoute<HomePageRoute>(
          path: '/',
          name: 'home',
          routes: [
            TypedGoRoute<SearchPageRoute>(path: 'search', name: 'search'),
            TypedGoRoute<NotificationsPageRoute>(path: 'notifications', name: 'notifications'),
            TypedGoRoute<OccasionsPageRoute>(path: 'occasions', name: 'occasions'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<CategoriesPageRouteBranchData>(
      routes: [
        TypedGoRoute<CategoriesPageRoute>(
          path: '/categories',
          name: 'categories',
        ),
      ],
    ),
    TypedStatefulShellBranch<AssistancePageRouteBranchData>(
      routes: [
        TypedGoRoute<AssistancePageRoute>(path: '/assistance', name: 'assistance'),
      ],
    ),
    TypedStatefulShellBranch<CartPageRouteBranchData>(
      routes: [
        TypedGoRoute<CartPageRoute>(path: '/cart', name: 'cart'),
      ],
    ),
    TypedStatefulShellBranch<ProfilePageRouteBranchData>(
      routes: [
        TypedGoRoute<ProfilePageRoute>(
          path: '/profile',
          name: 'profile',
          routes: [
            TypedGoRoute<SettingsPageRoute>(
              path: 'settings',
              name: 'settings',
              routes: [
                TypedGoRoute<LanguageSettingsPageRoute>(path: 'language', name: 'language-settings'),
                TypedGoRoute<NotificationsSettingsPageRoute>(path: 'notifications', name: 'notifications-settings'),
              ],
            ),
            TypedGoRoute<EventsPageRoute>(path: 'events', name: 'events'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<VendorPageRouteBranchData>(
      routes: [
        TypedGoRoute<VendorPageRoute>(path: '/vendor', name: 'vendor'),
      ],
    ),
  ],
)
class MainPageRoute extends StatefulShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return _MainPageShell(navigationShell: navigationShell);
  }
}
```

**Shell route rules**:

- Each bottom nav tab is a **branch** with its own navigator stack
- `StatefulNavigationShell` preserves state across tab switches
- Custom `onTap` handlers on nav items for auth-gating
- `navigationShell.goBranch(index)` switches tabs
- Sub-routes nest under their parent branch (e.g., search is under home)

### 10.10 Feature barrel pattern

```dart
// features/{{feature_name}}/{{feature_name}}.dart
export 'pages/pages.dart';

// features/{{feature_name}}/pages/pages.dart
export '{{page_name}}/{{page_name}}.dart';

// features/{{feature_name}}/pages/{{page_name}}/{{page_name}}.dart
export '{{page_name}}_page.dart';
export '{{page_name}}_page_wrapper.dart';
export 'bloc/{{page_name}}_bloc.dart';
export 'widgets/widgets.dart';

// features/features.dart (top-level)
export 'auth/auth.dart';
export 'home/home.dart';
export 'vendor/vendor.dart';
export 'cart/cart.dart';
export 'categories/categories.dart';
export 'profile/profile.dart';
export 'onboarding/onboarding.dart';
export 'settings/settings.dart';
export 'notifications/notifications.dart';
export 'events/events.dart';
export 'favorites/favorites.dart';
export 'assistance/assistance.dart';
```

### 10.11 Feature checklist (adding a new feature)

1. **Create folder**: `lib/features/{{feature_name}}/`
2. **Create barrel**: `{{feature_name}}.dart` → `export 'pages/pages.dart';`
3. **Register in features.dart**: Add `export '{{feature_name}}/{{feature_name}}.dart';`
4. **Create page folder**: `pages/{{page_name}}/`
5. **Create page**: `{{page_name}}_page.dart` — pure UI with widget slots
6. **Create bloc**: `bloc/{{page_name}}_bloc.dart` + event + state (use `part`)
7. **Create wrapper**: `{{page_name}}_page_wrapper.dart` — BlocBuilder/Listener → Page
8. **Create route**: `{{page_name}}_page_route.dart` — `part of app_routes.dart`, `@TypedGoRoute`, creates BlocProvider
9. **Register route**: Add `part` directive to `app_routes.dart`
10. **Run codegen**: `dart run build_runner build --delete-conflicting-outputs`
11. **Add to shell** (if it's a tab): Add `TypedStatefulShellBranch` to `MainPageRoute`
12. **Add to nav bar**: Add `EventiBottomNavigationBarItem` to `_MainPageShell`

---

## END OF PART 3

Say **"continue"** to receive **Part 4 — Master Build Order + Quick-Action Checklists**.
