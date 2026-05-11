import 'dart:async';
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
import 'package:dio_leaderboard_repository/dio_leaderboard_repository.dart';
import 'package:dio_student_analytics_repository/dio_student_analytics_repository.dart';
import 'package:dio_student_communication_repository/dio_student_communication_repository.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:analytics_service/analytics_service.dart';
import 'package:error_tracking_service/error_tracking_service.dart';

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
import 'package:mock_student_communication_repository/mock_student_communication_repository.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';
import 'package:mock_leaderboard_repository/mock_leaderboard_repository.dart';
import 'package:mock_student_analytics_repository/mock_student_analytics_repository.dart';

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
  final LeaderboardRepository leaderboardRepository;
  final StudentCommunicationRepository communicationRepository;
  final StudentAnalyticsRepository studentAnalyticsRepository;
  final AnalyticsService analyticsService;
  final ErrorTrackingService errorTrackingService;

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
    required this.leaderboardRepository,
    required this.communicationRepository,
    required this.studentAnalyticsRepository,
    required this.analyticsService,
    required this.errorTrackingService,
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
      leaderboardRepository,
      communicationRepository,
      studentAnalyticsRepository,
      analyticsService,
      errorTrackingService,
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
      RepositoryProvider<LeaderboardRepository>(
        create: (_) => leaderboardRepository,
      ),
      RepositoryProvider<StudentCommunicationRepository>(
        create: (_) => communicationRepository,
      ),
      RepositoryProvider<StudentAnalyticsRepository>(
        create: (_) => studentAnalyticsRepository,
      ),
      RepositoryProvider<AnalyticsService>(create: (_) => analyticsService),
      RepositoryProvider<ErrorTrackingService>(
        create: (_) => errorTrackingService,
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
  static DeviceInfoService? _deviceInfoService;
  static AnalyticsService? _analyticsService;
  static ErrorTrackingService? _errorTrackingService;

  static DeviceInfoService _initDeviceInfoService() {
    return _deviceInfoService ??= DeviceInfoServiceImpl();
  }

  static Future<AnalyticsService> _initAnalyticsService() async {
    if (_analyticsService != null) return _analyticsService!;
    final AnalyticsService analyticsService = FirebaseAnalyticsService();
    await analyticsService.initialize();
    _analyticsService = analyticsService;
    return analyticsService;
  }
  
  static Future<ErrorTrackingService> _initErrorTrackingService() async {
    if (_errorTrackingService != null) return _errorTrackingService!;
    final ErrorTrackingService errorTrackingService =
        SentryErrorTrackingService();
    await errorTrackingService.initialize();
    _errorTrackingService = errorTrackingService;
    return errorTrackingService;
  }

  static Future<CacheRepository> _initCacheRepository() async {
    if (_cacheRepository != null) return _cacheRepository!;
    final CacheRepository cacheRepository =
        FlutterSecureStorageCacheRepository();
    await cacheRepository.initialize();
    _cacheRepository = cacheRepository;
    return cacheRepository;
  }

  static Completer<HttpClient>? _httpClientCompleter;

  static Future<HttpClient> _initHttpClient() async {
    if (_httpClientCompleter != null) return _httpClientCompleter!.future;
    
    _httpClientCompleter = Completer<HttpClient>();
    
    try {
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
      await httpClient.initialize();

      // Use DeviceInfoService to get the hardware identifier as a fallback.
      final deviceInfoService = _initDeviceInfoService();
      final hardwareId = await deviceInfoService.getDeviceHash();
      
      // Only set the hardware ID as default if we don't already have a cached one 
      // (e.g., a server-generated hash from a previous session).
      if (httpClient.deviceId == null || httpClient.deviceId!.isEmpty) {
        httpClient.setDefaultHeader(NetworkConstants.deviceIdHeader, hardwareId);
      }

      isHttpClientInitialized = true;
      _httpClientCompleter!.complete(httpClient);
      return httpClient;
    } catch (e, s) {
      _httpClientCompleter!.completeError(e, s);
      _httpClientCompleter = null; // Reset to allow retry
      rethrow;
    }
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
          deviceInfoService: _initDeviceInfoService(),
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
        return DioStudentRegistrationRepository(
          httpClient: httpClient,
          deviceInfoService: _initDeviceInfoService(),
        );
    }
  }

  static Future<LeaderboardRepository> _initLeaderboardRepository() async {
    switch (Env.homeRepositoryMode) {
      // Reuse home mode for leaderboard or add its own env
      case RepositoryMode.mock:
        return MockLeaderboardRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioLeaderboardRepository(httpClient: httpClient);
    }
  }

  static Future<StudentCommunicationRepository> _initCommunicationRepository() async {
    switch (Env.homeRepositoryMode) { // Reusing home mode for now
      case RepositoryMode.mock:
        return MockStudentCommunicationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioStudentCommunicationRepository(httpClient: httpClient);
    }
  }

  static Future<StudentAnalyticsRepository>
  _initStudentAnalyticsRepository() async {
    switch (Env.analyticsRepositoryMode) {
      case RepositoryMode.mock:
        return MockStudentAnalyticsRepository();
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioStudentAnalyticsRepository(client: httpClient as DioHttpClient);
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

    // Initialize HttpClient early and once to avoid race conditions when 
    // multiple repositories are initialized in parallel via Future.wait
    await _initHttpClient();

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
      leaderboardRepository as LeaderboardRepository,
      communicationRepository as StudentCommunicationRepository,
      studentAnalyticsRepository as StudentAnalyticsRepository,
      analyticsService as AnalyticsService,
      errorTrackingService as ErrorTrackingService,
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
        _initLeaderboardRepository(),
        _initCommunicationRepository(),
        _initStudentAnalyticsRepository(),
        _initAnalyticsService(),
        _initErrorTrackingService(),
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
      leaderboardRepository: leaderboardRepository,
      communicationRepository: communicationRepository,
      studentAnalyticsRepository: studentAnalyticsRepository,
      analyticsService: analyticsService,
      errorTrackingService: errorTrackingService,
    );
    final localizedClients = <LocalizedClient>[];
    if (_httpClient != null && _httpClient is LocalizedClient) {
      localizedClients.add(_httpClient! as LocalizedClient);
    }

    return (repositories: repos, localizedClients: localizedClients);
  }
}
