import 'dart:ui';

import 'mentorx_student.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
import 'initializers/initializers.dart';

final class MentorXRequirements {
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

  static final MentorXLogger _logger = MentorXLogger('MentorXRequirements');

  MentorXRequirements({
    required this.blocs,
    required this.locale,
    required this.brightness,
    required this.repositories,
    required this.routerConfig,
  });

  static Future<MentorXRequirements> initialize() async {
    MentorXLogger.enabled = kDebugMode;
    await _initSystemUIStyle();
    final repositories = await RepositoriesFactory.initRepositories();
    final languageCode = RepositoriesFactory.initialLanguageCode;
    final initalBrightness = await _initBrightness(
      repositories.cacheRepository,
    );
    _logger.info(
      'Initializing the application with language $languageCode, brightness $initalBrightness',
    );
    await LocaleSettings.setLocaleRaw(languageCode);

    StudentEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
    } catch (e, s) {
      _logger.error('Failed to get cached user: ', e, s);
    }

    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      brightness: initalBrightness,
      cacheRepository: repositories.cacheRepository,
    );

    final String initialRoute = await _determineTheInitialRoute(
      user: user,
      cacheRepository: repositories.cacheRepository,
    );

    final AppRouter appRouter = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
    );
    return MentorXRequirements(
      blocs: blocs,
      repositories: repositories,
      locale: Locale(languageCode),
      brightness: initalBrightness,
      routerConfig: appRouter.routes,
    );
  }

  /// Loads the app's brightness setting from the cache.
  ///
  /// If the brightness is not set in the cache, it defaults to the device's
  /// current brightness setting. If the cached value is not a valid brightness
  /// setting name, it also defaults to the device's current brightness setting.
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

  static Future<String> _determineTheInitialRoute({
    required CacheRepository cacheRepository,
    required StudentEntity? user,
  }) async {
    if (user != null) {
      return switch (user.status) {
        StudentStatus.active => '/',
        StudentStatus.pending => '/status-pending',
        StudentStatus.blocked => '/status-blocked',
        StudentStatus.suspended => '/status-blocked',
        StudentStatus.rejected => '/status-rejected',
      };
    }

    final hasSeenOnboarding = await cacheRepository.get('has_seen_onboarding');
    if (hasSeenOnboarding == null) {
      return '/walkthrough';
    }

    return '/login';
  }
}
