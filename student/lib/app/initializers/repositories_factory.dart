import 'dart:ui';

import 'package:student_authentication_repository/dio_authentication_repository.dart';
import 'package:student_home_repository/dio_home_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:student_core/student_core.dart';

import 'package:student_mock_authentication_repository/mock_authentication_repository.dart';
import 'package:mock_home_repository/mock_home_repository.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mock_attendance_repository/mock_attendance_repository.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';
import 'package:mock_notification_repository/mock_notification_repository.dart';
import 'package:mock_settings_repository/mock_settings_repository.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';
import 'package:mock_ai_repository/mock_ai_repository.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import '../../core/utils/env.dart';

final class AppRepositories {
  final CacheRepository cacheRepository;
  final StudentAuthenticationRepository authenticationRepository;
  final StudentHomeRepository homeRepository;
  final CourseRepository courseRepository;
  final AttendanceRepository attendanceRepository;
  final WalletRepository walletRepository;
  final NotificationRepository notificationRepository;
  final SettingsRepository settingsRepository;
  final ProfileRepository profileRepository;
  final QuizRepository quizRepository;
  final AssignmentRepository assignmentRepository;
  final AIRepository aiRepository;
  final MarketplaceRepository marketplaceRepository;

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
    required this.homeRepository,
    required this.courseRepository,
    required this.attendanceRepository,
    required this.walletRepository,
    required this.notificationRepository,
    required this.settingsRepository,
    required this.profileRepository,
    required this.quizRepository,
    required this.assignmentRepository,
    required this.aiRepository,
    required this.marketplaceRepository,
  });

  List<Object> toList() {
    return [
      cacheRepository,
      authenticationRepository,
      homeRepository,
      courseRepository,
      attendanceRepository,
      walletRepository,
      notificationRepository,
      settingsRepository,
      profileRepository,
      quizRepository,
      assignmentRepository,
      aiRepository,
      marketplaceRepository,
    ];
  }

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<StudentAuthenticationRepository>(
        create: (_) => authenticationRepository,
      ),
      RepositoryProvider<StudentHomeRepository>(create: (_) => homeRepository),
      RepositoryProvider<CourseRepository>(create: (_) => courseRepository),
      RepositoryProvider<AttendanceRepository>(
        create: (_) => attendanceRepository,
      ),
      RepositoryProvider<WalletRepository>(create: (_) => walletRepository),
      RepositoryProvider<NotificationRepository>(
        create: (_) => notificationRepository,
      ),
      RepositoryProvider<SettingsRepository>(
        create: (_) => settingsRepository,
      ),
      RepositoryProvider<ProfileRepository>(create: (_) => profileRepository),
      RepositoryProvider<QuizRepository>(create: (_) => quizRepository),
      RepositoryProvider<AssignmentRepository>(
        create: (_) => assignmentRepository,
      ),
      RepositoryProvider<AIRepository>(create: (_) => aiRepository),
      RepositoryProvider<MarketplaceRepository>(
        create: (_) => marketplaceRepository,
      ),
    ];
  }
}

final class RepositoriesFactory {
  RepositoriesFactory._();

  static HttpClient? _httpClient;
  static bool isHttpClientInitialized = false;

  static late final String initialLanguageCode;

  static CacheRepository? _cacheRepository;

  static Future<CacheRepository> _initCacheRepository() async {
    if (_cacheRepository != null) return _cacheRepository!;
    final CacheRepository cacheRepository =
        FlutterSecureStorageCacheRepository();
    await cacheRepository.initialize();
    _cacheRepository = cacheRepository;
    return cacheRepository;
  }

  static Future<HttpClient> _initHttpClient() async {
    if (isHttpClientInitialized && _httpClient != null) return _httpClient!;
    if (!Env.hasMentorXBaseUrl) {
      throw StateError(
        'MENTORX_API_BASE_URL is required when any repository mode is PROD.',
      );
    }
    final cacheRepository = await _initCacheRepository();
    final httpClient = DioHttpClient(
      baseUrl: Env.mentorXBaseUrl,
      cacheRepository: cacheRepository,
    );
    _httpClient = httpClient;
    isHttpClientInitialized = true;
    return httpClient;
  }

  static Future<StudentAuthenticationRepository>
  _initAuthenticationRepository() async {
    late final StudentAuthenticationRepository repo;
    switch (Env.authenticationRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockAuthenticationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        final cacheRepository = await _initCacheRepository();
        repo = DioAuthenticationRepository(
          httpClient: httpClient,
          cacheRepository: cacheRepository,
        );
    }
    await repo.initialize();
    return repo;
  }

  static Future<StudentHomeRepository> _initHomeRepository() async {
    switch (Env.homeRepositoryMode) {
      case RepositoryMode.mock:
        return MockHomeRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioHomeRepository(httpClient: httpClient);
    }
  }

  static Future<CourseRepository> _initCourseRepository() async {
    switch (Env.courseRepositoryMode) {
      case RepositoryMode.mock:
        return MockCourseRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'COURSE_REPOSITORY_MODE=prod is not supported yet because DioCourseRepository is missing.',
        );
    }
  }

  static Future<AttendanceRepository> _initAttendanceRepository() async {
    switch (Env.attendanceRepositoryMode) {
      case RepositoryMode.mock:
        return MockAttendanceRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'ATTENDANCE_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<WalletRepository> _initWalletRepository() async {
    switch (Env.walletRepositoryMode) {
      case RepositoryMode.mock:
        return MockWalletRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'WALLET_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<NotificationRepository> _initNotificationRepository() async {
    switch (Env.notificationRepositoryMode) {
      case RepositoryMode.mock:
        return MockNotificationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'NOTIFICATION_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<SettingsRepository> _initSettingsRepository() async {
    switch (Env.settingsRepositoryMode) {
      case RepositoryMode.mock:
        return MockSettingsRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'SETTINGS_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<ProfileRepository> _initProfileRepository() async {
    switch (Env.profileRepositoryMode) {
      case RepositoryMode.mock:
        return MockProfileRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'PROFILE_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<QuizRepository> _initQuizRepository() async {
    switch (Env.quizRepositoryMode) {
      case RepositoryMode.mock:
        return MockQuizRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'QUIZ_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<AssignmentRepository> _initAssignmentRepository() async {
    switch (Env.assignmentRepositoryMode) {
      case RepositoryMode.mock:
        return MockAssignmentRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'ASSIGNMENT_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<AIRepository> _initAIRepository() async {
    switch (Env.aiRepositoryMode) {
      case RepositoryMode.mock:
        return MockAIRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'AI_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static Future<MarketplaceRepository> _initMarketplaceRepository() async {
    switch (Env.marketplaceRepositoryMode) {
      case RepositoryMode.mock:
        return MockMarketplaceRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        throw UnsupportedError(
          'MARKETPLACE_REPOSITORY_MODE=prod is not supported yet.',
        );
    }
  }

  static String _defaultLanguageCode() {
    final deviceLanguageCode = PlatformDispatcher.instance.locale.languageCode;
    final supportedLocales = LocaleSettings.instance.supportedLocalesRaw;
    return supportedLocales.contains(deviceLanguageCode)
        ? deviceLanguageCode
        : supportedLocales.contains(Env.defaultLanguageCode)
        ? Env.defaultLanguageCode
        : supportedLocales.first;
  }

  static Future<({AppRepositories repositories, List<LocalizedClient> localizedClients})> initRepositories() async {
    if (Env.usesAnyProdRepository && !Env.hasMentorXBaseUrl) {
      throw StateError(
        'MENTORX_API_BASE_URL must be provided when any repository mode is PROD.',
      );
    }

    final CacheRepository cacheRepository = await _initCacheRepository();
    initialLanguageCode =
        await cacheRepository.get(
          CacheKeys.languageCode,
        ) ??
        _defaultLanguageCode();

    final [
      authenticationRepository as StudentAuthenticationRepository,
      homeRepository as StudentHomeRepository,
      courseRepository as CourseRepository,
      attendanceRepository as AttendanceRepository,
      walletRepository as WalletRepository,
      notificationRepository as NotificationRepository,
      settingsRepository as SettingsRepository,
      profileRepository as ProfileRepository,
      quizRepository as QuizRepository,
      assignmentRepository as AssignmentRepository,
      aiRepository as AIRepository,
      marketplaceRepository as MarketplaceRepository,
    ] = await Future.wait(
      [
        _initAuthenticationRepository(),
        _initHomeRepository(),
        _initCourseRepository(),
        _initAttendanceRepository(),
        _initWalletRepository(),
        _initNotificationRepository(),
        _initSettingsRepository(),
        _initProfileRepository(),
        _initQuizRepository(),
        _initAssignmentRepository(),
        _initAIRepository(),
        _initMarketplaceRepository(),
      ],
    );
    final repos = AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: authenticationRepository,
      homeRepository: homeRepository,
      courseRepository: courseRepository,
      attendanceRepository: attendanceRepository,
      walletRepository: walletRepository,
      notificationRepository: notificationRepository,
      settingsRepository: settingsRepository,
      profileRepository: profileRepository,
      quizRepository: quizRepository,
      assignmentRepository: assignmentRepository,
      aiRepository: aiRepository,
      marketplaceRepository: marketplaceRepository,
    );
    return (repositories: repos, localizedClients: <LocalizedClient>[]);
  }
}
