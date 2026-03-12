import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../core/core.dart';
import 'initializers/initializers.dart';

// ──────────────────────────────────────────────────────────────────────────────
// ParentRequirements — holds everything the root widget needs to start the app.
// ──────────────────────────────────────────────────────────────────────────────

final class ParentRequirements {
  final Locale locale;
  final Brightness brightness;
  final AppBlocs blocs;
  final AppRepositories repositories;
  final RouterConfig<Object> routerConfig;

  const ParentRequirements._({
    required this.locale,
    required this.brightness,
    required this.blocs,
    required this.repositories,
    required this.routerConfig,
  });

  static final MentorXLogger _logger = MentorXLogger('ParentRequirements');

  // ──────────────────────────────────────────────────────────────────────────
  // Initialization pipeline (called once from main.dart)
  // ──────────────────────────────────────────────────────────────────────────

  static Future<ParentRequirements> initialize() async {
    MentorXLogger.enabled = kDebugMode;

    await _initSystemUIStyle();

    // 1. Initialize repositories in parallel
    final repositories = await RepositoriesFactory.initRepositories();
    final languageCode = RepositoriesFactory.initialLanguageCode;
    _logger.info('Repositories initialized. Language: $languageCode');

    // 2. Load brightness from cache
    final brightness = await _initBrightness(repositories.cacheRepository);
    _logger.info('Brightness: $brightness');

    // 3. Load cached user
    ParentEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
      if (user != null) _logger.info('Cached user found: ${user.name}');
    } catch (e, s) {
      _logger.error('Failed to load cached user', e, s);
    }

    // 4. Initialize all app-level cubits
    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      repositories: repositories,
    );

    // 5. Determine initial route
    final initialRoute = await _determineInitialRoute(
      user: user,
      cacheRepository: repositories.cacheRepository,
    );
    _logger.info('Initial route: $initialRoute');

    // 6. Build router
    final routerConfig = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
    ).routes;

    return ParentRequirements._(
      locale: Locale(languageCode),
      brightness: brightness,
      blocs: blocs,
      repositories: repositories,
      routerConfig: routerConfig,
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Private helpers
  // ──────────────────────────────────────────────────────────────────────────

  static Future<Brightness> _initBrightness(
    CacheRepository cacheRepository,
  ) async {
    final cached = await cacheRepository.get(CacheKeys.brightness);
    final deviceBrightness = PlatformDispatcher.instance.platformBrightness;
    if (cached == null) return deviceBrightness;
    if (cached == Brightness.light.name) return Brightness.light;
    if (cached == Brightness.dark.name) return Brightness.dark;
    return deviceBrightness;
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
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Future<String> _determineInitialRoute({
    required ParentEntity? user,
    required CacheRepository cacheRepository,
  }) async {
    if (user == null) {
      return const LoginPageRoute().location;
    }
    return const HomePageRoute().location;
  }
}
