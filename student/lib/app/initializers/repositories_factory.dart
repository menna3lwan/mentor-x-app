import 'dart:ui';

import 'package:dio_authentication_repository/dio_authentication_repository.dart';
import 'package:dio_home_repository/dio_home_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

import 'package:dio_course_repository/dio_course_repository.dart';
import 'package:dio_attendance_repository/dio_attendance_repository.dart';
import 'package:dio_wallet_repository/dio_wallet_repository.dart';
import 'package:dio_notification_repository/dio_notification_repository.dart';
import 'package:dio_profile_repository/dio_profile_repository.dart';
import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'package:dio_assignment_repository/dio_assignment_repository.dart';
import 'package:dio_ai_repository/dio_ai_repository.dart';
import 'package:dio_marketplace_repository/dio_marketplace_repository.dart';
import 'package:dio_rewards_repository/dio_rewards_repository.dart';
import 'package:dio_grade_repository/dio_grade_repository.dart';
import 'package:dio_announcement_repository/dio_announcement_repository.dart';
import 'package:dio_settings_repository/dio_settings_repository.dart';
import 'package:dio_student_registration_repository/dio_student_registration_repository.dart';

import 'package:mock_authentication_repository/mock_authentication_repository.dart';
import 'package:mock_home_repository/mock_home_repository.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mock_attendance_repository/mock_attendance_repository.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';
import 'package:mock_notification_repository/mock_notification_repository.dart';
import 'package:mock_settings_repository/mock_settings_repository.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';
import 'package:mock_ai_repository/mock_ai_repository.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';
import 'package:mock_announcement_repository/mock_announcement_repository.dart';
import 'package:mock_rewards_repository/mock_rewards_repository.dart';
import 'package:mock_grade_repository/mock_grade_repository.dart';
import 'package:mock_student_registration_repository/mock_student_registration_repository.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

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
  final RewardsRepository rewardsRepository;
  final GradeRepository gradeRepository;
  final AnnouncementRepository announcementRepository;
  final StudentRegistrationRepository registrationRepository;

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
    required this.rewardsRepository,
    required this.gradeRepository,
    required this.announcementRepository,
    required this.registrationRepository,
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
      rewardsRepository,
      gradeRepository,
      announcementRepository,
      registrationRepository,
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
      RepositoryProvider<RewardsRepository>(create: (_) => rewardsRepository),
      RepositoryProvider<GradeRepository>(create: (_) => gradeRepository),
      RepositoryProvider<AnnouncementRepository>(
        create: (_) => announcementRepository,
      ),
      RepositoryProvider<StudentRegistrationRepository>(
        create: (_) => registrationRepository,
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
        return DioStudentHomeRepository(httpClient: httpClient);
    }
  }

  static Future<CourseRepository> _initCourseRepository() async {
    switch (Env.courseRepositoryMode) {
      case RepositoryMode.mock:
        return MockCourseRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioCourseRepository(httpClient: httpClient);
    }
  }

  static Future<AttendanceRepository> _initAttendanceRepository() async {
    switch (Env.attendanceRepositoryMode) {
      case RepositoryMode.mock:
        return MockAttendanceRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioAttendanceRepository(httpClient: httpClient);
    }
  }

  static Future<WalletRepository> _initWalletRepository() async {
    switch (Env.walletRepositoryMode) {
      case RepositoryMode.mock:
        return MockWalletRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioWalletRepository(httpClient: httpClient);
    }
  }

  static Future<NotificationRepository> _initNotificationRepository() async {
    switch (Env.notificationRepositoryMode) {
      case RepositoryMode.mock:
        return MockNotificationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioNotificationRepository(httpClient: httpClient);
    }
  }

  static Future<SettingsRepository> _initSettingsRepository() async {
    switch (Env.settingsRepositoryMode) {
      case RepositoryMode.mock:
        return MockSettingsRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioSettingsRepository(httpClient: httpClient);
    }
  }

  static Future<AnnouncementRepository> _initAnnouncementRepository() async {
    switch (Env.announcementRepositoryMode) {
      case RepositoryMode.mock:
        return MockAnnouncementRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioAnnouncementRepository(httpClient: httpClient);
    }
  }

  static Future<ProfileRepository> _initProfileRepository() async {
    switch (Env.profileRepositoryMode) {
      case RepositoryMode.mock:
        return MockProfileRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioStudentProfileRepository(httpClient: httpClient);
    }
  }

  static Future<QuizRepository> _initQuizRepository() async {
    switch (Env.quizRepositoryMode) {
      case RepositoryMode.mock:
        return MockQuizRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioQuizRepository(httpClient: httpClient);
    }
  }

  static Future<AssignmentRepository> _initAssignmentRepository() async {
    switch (Env.assignmentRepositoryMode) {
      case RepositoryMode.mock:
        return MockAssignmentRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioAssignmentRepository(httpClient: httpClient);
    }
  }

  static Future<AIRepository> _initAIRepository() async {
    switch (Env.aiRepositoryMode) {
      case RepositoryMode.mock:
        return MockAIRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioAiRepository(httpClient: httpClient);
    }
  }

  static Future<MarketplaceRepository> _initMarketplaceRepository() async {
    switch (Env.marketplaceRepositoryMode) {
      case RepositoryMode.mock:
        return MockMarketplaceRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioMarketplaceRepository(httpClient: httpClient);
    }
  }

  static Future<RewardsRepository> _initRewardsRepository() async {
    switch (Env.rewardsRepositoryMode) {
      case RepositoryMode.mock:
        return MockRewardsRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioRewardsRepository(httpClient: httpClient);
    }
  }

  static Future<GradeRepository> _initGradeRepository() async {
    switch (Env.gradeRepositoryMode) {
      case RepositoryMode.mock:
        return MockGradeRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioGradeRepository(httpClient: httpClient);
    }
  }

  static Future<StudentRegistrationRepository>
  _initRegistrationRepository() async {
    switch (Env.registrationRepositoryMode) {
      case RepositoryMode.mock:
        return MockStudentRegistrationRepository();
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioStudentRegistrationRepository(httpClient: httpClient);
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

  static Future<
    ({AppRepositories repositories, List<LocalizedClient> localizedClients})
  >
  initRepositories() async {
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
      rewardsRepository as RewardsRepository,
      gradeRepository as GradeRepository,
      announcementRepository as AnnouncementRepository,
      registrationRepository as StudentRegistrationRepository,
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
        _initRewardsRepository(),
        _initGradeRepository(),
        _initAnnouncementRepository(),
        _initRegistrationRepository(),
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
      rewardsRepository: rewardsRepository,
      gradeRepository: gradeRepository,
      announcementRepository: announcementRepository,
      registrationRepository: registrationRepository,
    );
    final localizedClients = <LocalizedClient>[];
    if (_httpClient != null && _httpClient is LocalizedClient) {
      localizedClients.add(_httpClient! as LocalizedClient);
    }

    return (repositories: repos, localizedClients: localizedClients);
  }
}
