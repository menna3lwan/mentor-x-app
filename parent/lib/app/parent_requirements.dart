import 'dart:ui';

import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/core.dart';
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

    final services = await ServicesFactory.initServices();

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

    ParentEntity? user;
    try {
      user = await repositories.authenticationRepository.getCachedUser();
    } catch (e, s) {
      _logger.error('Failed to get cached user: ', e, s);
    }

    final blocs = await BlocsFactory.initBlocs(
      user: user,
      languageCode: languageCode,
      cacheRepository: repositories.cacheRepository,
      localizedClients: localizedClients,
    );

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
