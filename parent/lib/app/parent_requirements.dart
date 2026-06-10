import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
import '../firebase_options.dart';
import 'initializers/initializers.dart';

final class ParentRequirements {
  /// The application's current locale
  final Locale locale;

  /// The application's current brightness theme setting
  final Brightness brightness;

  /// List of BLoC providers for state management
  final AppBlocs blocs;

  /// List of repository providers for data access
  final AppRepositories repositories;

  /// Router configuration for navigation
  final RouterConfig<Object> routerConfig;

  /// Clients that receive locale updates when the app language changes
  final List<LocalizedClient> localizedClients;

  /// List of services for shared functionality
  final AppServices services;

  static final MentorXLogger _logger = MentorXLogger('ParentRequirements');

  ParentRequirements({
    required this.blocs,
    required this.locale,
    required this.brightness,
    required this.repositories,
    required this.routerConfig,
    required this.localizedClients,
    required this.services,
  });

  static Future<ParentRequirements> initialize() async {
    MentorXLogger.enabled = kDebugMode;
    await _initSystemUIStyle();
    // Initialize Firebase safely. The generated `DefaultFirebaseOptions`
    // may contain placeholder values (e.g. when `flutterfire configure`
    // hasn't been run or a `GoogleService-Info.plist` wasn't added).
    // Avoid passing invalid options to the native SDK which can throw
    // and terminate the app. Prefer options when they look valid, else
    // fall back to plist-based auto-configuration on Apple platforms.
    try {
      _logger.info('Starting Firebase initialization');
      final options = DefaultFirebaseOptions.currentPlatform;
      final apiKey = options.apiKey;

      final bool hasPlaceholderApiKey =
          apiKey.startsWith('PLACEHOLDER') || apiKey.isEmpty;

      if (hasPlaceholderApiKey &&
          (MentorXPlatformChecker.isIOS || MentorXPlatformChecker.isMacOS)) {
        _logger.info('Using plist-based Firebase init (placeholder API key)');
        await Firebase.initializeApp(); // let iOS/macOS read GoogleService-Info.plist
      } else {
        _logger.info('Using code-based Firebase init with provided options');
        await Firebase.initializeApp(options: options);
      }
      _logger.info('Firebase initialization completed');
    } catch (e, s) {
      MentorXLogger(
        'ParentRequirements',
      ).error('Firebase initialization failed', e, s);
      // Attempt a best-effort fallback: try plist-based init on Apple platforms.
      try {
        if (MentorXPlatformChecker.isIOS || MentorXPlatformChecker.isMacOS) {
          _logger.info('Attempting plist-based Firebase init fallback');
          await Firebase.initializeApp();
          _logger.info('Fallback plist-based Firebase init succeeded');
        }
      } catch (_) {
        _logger.warning(
          'Fallback plist-based Firebase init also failed; continuing without Firebase',
        );
      }
    }

    _logger.info('Initializing services');
    final services = await ServicesFactory.initServices();
    _logger.info('Services initialized');

    _logger.info('Initializing repositories');
    final (:repositories, :localizedClients) =
        await RepositoriesFactory.initRepositories();
    _logger.info('Repositories initialized');

    final languageCode = RepositoriesFactory.initialLanguageCode;
    final initalBrightness = await _initBrightness(
      repositories.cacheRepository,
    );

    _logger.info(
      'Initializing the application with language $languageCode, brightness $initalBrightness',
    );

    await LocaleSettings.setLocaleRaw(languageCode);

    ParentEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
    } catch (e, s) {
      _logger.error('Failed to get cached user: ', e, s);
    }

    _logger.info('Initializing blocs');
    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      cacheRepository: repositories.cacheRepository,
      localizedClients: localizedClients,
    );
    _logger.info('Blocs initialized');

    final AppRouter appRouter = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      authenticationCubit: blocs.appAuthenticationCubit,
    );

    return ParentRequirements(
      blocs: blocs,
      repositories: repositories,
      services: services,
      locale: Locale(languageCode),
      brightness: initalBrightness,
      routerConfig: appRouter.routes,
      localizedClients: localizedClients,
    );
  }

  /// Loads the app's brightness setting from the cache.
  static Future<Brightness> _initBrightness(
    CacheRepository cacheRepository,
  ) async {
    final String? brightness = await cacheRepository.get(
      CacheKeys.brightness,
    );
    final deviceBrightness = PlatformDispatcher.instance.platformBrightness;
    return (brightness == null)
        ? deviceBrightness
        : [Brightness.light.name, Brightness.dark.name].contains(brightness)
        ? Brightness.values.byName(brightness)
        : deviceBrightness;
  }

  static Future<void> _initSystemUIStyle() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).ignore();

    if (MentorXPlatformChecker.isIOS) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      ).ignore();
    }
  }
}
