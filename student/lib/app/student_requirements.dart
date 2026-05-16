import 'dart:ui';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'student_app.dart';
import 'package:mentorx_ui/mentorx_ui.dart' hide LocaleSettings, TranslationProvider;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mentorx_student/core/core.dart';
import 'initializers/initializers.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

final class StudentRequirements {
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

  static final MentorXLogger _logger = MentorXLogger('StudentRequirements');

  StudentRequirements({
    required this.blocs,
    required this.locale,
    required this.brightness,
    required this.repositories,
    required this.routerConfig,
    required this.localizedClients,
  });

  static Future<StudentRequirements> initialize() async {
    MentorXLogger.enabled = kDebugMode;
    await _initSystemUIStyle();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final (:repositories, :localizedClients) =
        await RepositoriesFactory.initRepositories();
    final languageCode = RepositoriesFactory.initialLanguageCode;
    final initalBrightness = await _initBrightness(
      repositories.cacheRepository,
    );
    _logger.info(
      'Initializing the application with language $languageCode, brightness $initalBrightness',
    );
    await LocaleSettings.setLocaleRaw(languageCode);
    MentorXLogger.onError = (message, error, stackTrace) {
      repositories.errorTrackingService.captureException(
        error ?? message,
        stackTrace: stackTrace,
        hint: error == null ? null : message,
      );
    };
    MentorXUI.onAnalyticsEvent = (name, parameters) {
      repositories.analyticsService.logEvent(
        name: name,
        parameters: parameters?.cast<String, Object?>(),
      );
    };

    StudentEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
    } catch (e, s) {
      _logger.error('Failed to get cached user: ', e, s);
    }
    if (user != null) {
      repositories.analyticsService.setUserId(user.id);
      repositories.errorTrackingService.setUserId(user.id);
    }

    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      brightness: initalBrightness,
      cacheRepository: repositories.cacheRepository,
      authenticationRepository: repositories.authenticationRepository,
      analyticsService: repositories.analyticsService,
      errorTrackingService: repositories.errorTrackingService,
      localizedClients: localizedClients,
    );

    final AppRouter appRouter = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/splash',
      analyticsService: repositories.analyticsService,
    );
    return StudentRequirements(
      blocs: blocs,
      repositories: repositories,
      locale: Locale(languageCode),
      brightness: initalBrightness,
      routerConfig: appRouter.routes,
      localizedClients: localizedClients,
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
    SentryWidgetsFlutterBinding.ensureInitialized();
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
