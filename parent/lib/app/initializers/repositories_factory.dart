import 'package:dio_http_client/dio_http_client.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

import 'package:parent_dio_authentication_repository/parent_dio_authentication_repository.dart';
import 'package:parent_dio_home_repository/parent_dio_home_repository.dart';
import 'package:parent_dio_children_repository/parent_dio_children_repository.dart';
import 'package:parent_dio_attendance_repository/parent_dio_attendance_repository.dart';
import 'package:parent_dio_course_repository/parent_dio_course_repository.dart';
import 'package:parent_dio_financial_repository/parent_dio_financial_repository.dart';
import 'package:parent_dio_grade_repository/parent_dio_grade_repository.dart';
import 'package:parent_dio_communication_repository/parent_dio_communication_repository.dart';
import 'package:parent_dio_notification_repository/parent_dio_notification_repository.dart';
import 'package:parent_dio_profile_repository/parent_dio_profile_repository.dart';
import 'package:parent_dio_analytics_repository/parent_dio_analytics_repository.dart';
import 'package:device_info_service/device_info_service.dart';

import 'package:parent_mock_authentication_repository/parent_mock_authentication_repository.dart';
import 'package:parent_mock_home_repository/parent_mock_home_repository.dart';
import 'package:parent_mock_children_repository/parent_mock_children_repository.dart';
import 'package:parent_mock_financial_repository/parent_mock_financial_repository.dart';
import 'package:parent_mock_course_repository/parent_mock_course_repository.dart';
import 'package:parent_mock_attendance_repository/parent_mock_attendance_repository.dart';
import 'package:parent_mock_grade_repository/parent_mock_grade_repository.dart';
import 'package:parent_mock_communication_repository/parent_mock_communication_repository.dart';
import 'package:mock_parent_profile_repository/mock_parent_profile_repository.dart';
import 'package:mock_parent_analytics_repository/mock_parent_analytics_repository.dart';
import 'package:mock_notification_repository/mock_notification_repository.dart';

import '../../core/utils/env.dart';

final class AppRepositories {
  final CacheRepository cacheRepository;
  final AuthenticationRepository<ParentEntity> authenticationRepository;
  final ParentHomeRepository homeRepository;
  final ParentChildrenRepository childrenRepository;
  final ParentFinancialRepository financialRepository;
  final ParentCourseRepository courseRepository;
  final ParentAttendanceRepository attendanceRepository;
  final ParentGradeRepository gradeRepository;
  final ParentCommunicationRepository communicationRepository;
  final NotificationRepository notificationRepository;
  final ParentProfileRepository profileRepository;
  final ParentAnalyticsRepository analyticsRepository;

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
    required this.homeRepository,
    required this.childrenRepository,
    required this.financialRepository,
    required this.courseRepository,
    required this.attendanceRepository,
    required this.gradeRepository,
    required this.communicationRepository,
    required this.notificationRepository,
    required this.profileRepository,
    required this.analyticsRepository,
  });

  List<Object> toList() {
    return [
      cacheRepository,
      authenticationRepository,
      homeRepository,
      childrenRepository,
      financialRepository,
      courseRepository,
      attendanceRepository,
      gradeRepository,
      communicationRepository,
      notificationRepository,
      profileRepository,
      analyticsRepository,
    ];
  }

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<AuthenticationRepository<ParentEntity>>(
        create: (_) => authenticationRepository,
      ),
      RepositoryProvider<ParentHomeRepository>(create: (_) => homeRepository),
      RepositoryProvider<ParentChildrenRepository>(
        create: (_) => childrenRepository,
      ),
      RepositoryProvider<ParentFinancialRepository>(
        create: (_) => financialRepository,
      ),
      RepositoryProvider<ParentCourseRepository>(
        create: (_) => courseRepository,
      ),
      RepositoryProvider<ParentAttendanceRepository>(
        create: (_) => attendanceRepository,
      ),
      RepositoryProvider<ParentGradeRepository>(create: (_) => gradeRepository),
      RepositoryProvider<ParentCommunicationRepository>(
        create: (_) => communicationRepository,
      ),
      RepositoryProvider<NotificationRepository>(
        create: (_) => notificationRepository,
      ),
      RepositoryProvider<ParentProfileRepository>(
        create: (_) => profileRepository,
      ),
      RepositoryProvider<ParentAnalyticsRepository>(
        create: (_) => analyticsRepository,
      ),
    ];
  }
}

final class RepositoriesFactory {
  RepositoriesFactory._();

  // Each lazy resource is memoized by *future* — not by boolean — so any
  // number of concurrent callers (e.g. inside `Future.wait`) share a single
  // initialization. This eliminates the previous race where two callers
  // could see `isHttpClientInitialized == false`, both create a `DioHttpClient`,
  // and one would silently overwrite the other.
  static Future<HttpClient>? _httpClientFuture;
  static Future<CacheRepository>? _cacheRepositoryFuture;

  static HttpClient? _httpClient;

  static late final String initialLanguageCode;

  static DeviceInfoService? _deviceInfoService;

  /// Visible to tests so they can reset the singleton state between runs.
  /// Production code never calls this.
  @visibleForTesting
  static void resetForTests() {
    _httpClientFuture = null;
    _cacheRepositoryFuture = null;
    _httpClient = null;
    _deviceInfoService = null;
  }

  static DeviceInfoService _initDeviceInfoService() {
    return _deviceInfoService ??= DeviceInfoServiceImpl();
  }

  static Future<CacheRepository> _initCacheRepository() {
    return _cacheRepositoryFuture ??= _createCacheRepository();
  }

  static Future<CacheRepository> _createCacheRepository() async {
    final CacheRepository cacheRepository =
        FlutterSecureStorageCacheRepository();
    await cacheRepository.initialize();
    return cacheRepository;
  }

  static Future<HttpClient> _initHttpClient() {
    return _httpClientFuture ??= _createHttpClient();
  }

  static Future<HttpClient> _createHttpClient() async {
    if (!Env.hasMentorXBaseUrl) {
      throw StateError(
        'MENTORX_API_BASE_URL is required when any repository mode is PROD. '
        'Pass it via --dart-define-from-file=.env or '
        '--dart-define=MENTORX_API_BASE_URL=...',
      );
    }
    final cacheRepository = await _initCacheRepository();
    final httpClient = DioHttpClient(
      baseUrl: Env.mentorXBaseUrl,
      cacheRepository: cacheRepository,
    );
    await httpClient.initialize();

    // Use DeviceInfoService to get the hardware identifier as a fallback.
    final deviceInfoService = _initDeviceInfoService();
    final hardwareId = await deviceInfoService.getDeviceHash();

    // Only set the hardware ID as default if we don't already have a cached
    // one (e.g. a server-generated hash from a previous session).
    if (httpClient.deviceId == null || httpClient.deviceId!.isEmpty) {
      httpClient.setDefaultHeader(NetworkConstants.deviceIdHeader, hardwareId);
    }

    _httpClient = httpClient;
    return httpClient;
  }

  static Future<AuthenticationRepository<ParentEntity>>
  _initAuthenticationRepository() async {
    late final AuthenticationRepository<ParentEntity> repo;
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

  static Future<ParentHomeRepository> _initHomeRepository() async {
    late final ParentHomeRepository repo;
    switch (Env.homeRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockParentHomeRepository();
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioParentHomeRepository(httpClient: httpClient);
    }
    await repo.initialize();
    return repo;
  }

  static Future<ParentChildrenRepository> _initChildrenRepository() async {
    late final ParentChildrenRepository repo;
    switch (Env.childrenRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockChildrenRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioParentChildrenRepository(httpClient: httpClient);
    }
    await repo.initialize();
    return repo;
  }

  static Future<ParentFinancialRepository> _initFinancialRepository() async {
    switch (Env.financialRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentFinancialRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentFinancialRepository(httpClient: httpClient);
    }
  }

  static Future<ParentCourseRepository> _initCourseRepository() async {
    switch (Env.courseRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentCourseRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentCourseRepository(httpClient: httpClient);
    }
  }

  static Future<ParentAttendanceRepository> _initAttendanceRepository() async {
    switch (Env.attendanceRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentAttendanceRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentAttendanceRepository(httpClient: httpClient);
    }
  }

  static Future<ParentGradeRepository> _initGradeRepository() async {
    switch (Env.gradeRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentGradeRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentGradeRepository(httpClient: httpClient);
    }
  }

  static Future<ParentCommunicationRepository>
  _initCommunicationRepository() async {
    switch (Env.communicationRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentCommunicationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentCommunicationRepository(httpClient: httpClient);
    }
  }

  static Future<ParentProfileRepository> _initProfileRepository() async {
    late final ParentProfileRepository repo;
    switch (Env.profileRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockParentProfileRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioParentProfileRepository(httpClient: httpClient);
    }
    await repo.initialize();
    return repo;
  }

  static Future<ParentAnalyticsRepository> _initAnalyticsRepository() async {
    late final ParentAnalyticsRepository repo;
    switch (Env.analyticsRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockParentAnalyticsRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioParentAnalyticsRepository(httpClient: httpClient);
    }
    await repo.initialize();
    return repo;
  }

  static Future<NotificationRepository> _initNotificationRepository() async {
    late final NotificationRepository repo;
    switch (Env.notificationRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockNotificationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioParentNotificationRepository(httpClient: httpClient);
    }
    await repo.initialize();
    return repo;
  }

  static String _defaultLanguageCode() {
    // In a real app, you'd use a locale setting package like student app does
    // For now, simpler implementation or fallback
    return Env.defaultLanguageCode;
  }

  static Future<
    ({AppRepositories repositories, List<LocalizedClient> localizedClients})
  >
  initRepositories() async {
    if (Env.usesAnyProdRepository && !Env.hasMentorXBaseUrl) {
      throw StateError(
        'MENTORX_API_BASE_URL must be provided when any repository mode is '
        'PROD. Pass it via --dart-define-from-file=.env or '
        '--dart-define=MENTORX_API_BASE_URL=...',
      );
    }

    final CacheRepository cacheRepository = await _initCacheRepository();
    // Pre-initialize HttpClient (only if any repository needs it) to avoid
    // race conditions inside the Future.wait below. Memoization in
    // `_initHttpClient` itself guarantees idempotency, so calling it twice
    // is safe; pre-warming just makes the first call sequential.
    if (Env.usesAnyProdRepository) {
      await _initHttpClient();
    }

    initialLanguageCode =
        await cacheRepository.get(CacheKeys.languageCode) ??
        _defaultLanguageCode();

    final [
      authenticationRepository as AuthenticationRepository<ParentEntity>,
      homeRepository as ParentHomeRepository,
      childrenRepository as ParentChildrenRepository,
      financialRepository as ParentFinancialRepository,
      courseRepository as ParentCourseRepository,
      attendanceRepository as ParentAttendanceRepository,
      gradeRepository as ParentGradeRepository,
      communicationRepository as ParentCommunicationRepository,
      notificationRepository as NotificationRepository,
      profileRepository as ParentProfileRepository,
      analyticsRepository as ParentAnalyticsRepository,
    ] = await Future.wait(
      [
        _initAuthenticationRepository(),
        _initHomeRepository(),
        _initChildrenRepository(),
        _initFinancialRepository(),
        _initCourseRepository(),
        _initAttendanceRepository(),
        _initGradeRepository(),
        _initCommunicationRepository(),
        _initNotificationRepository(),
        _initProfileRepository(),
        _initAnalyticsRepository(),
      ],
    );

    final repos = AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: authenticationRepository,
      homeRepository: homeRepository,
      childrenRepository: childrenRepository,
      financialRepository: financialRepository,
      courseRepository: courseRepository,
      attendanceRepository: attendanceRepository,
      gradeRepository: gradeRepository,
      communicationRepository: communicationRepository,
      notificationRepository: notificationRepository,
      profileRepository: profileRepository,
      analyticsRepository: analyticsRepository,
    );

    final localizedClients = <LocalizedClient>[];
    if (_httpClient != null && _httpClient is LocalizedClient) {
      localizedClients.add(_httpClient! as LocalizedClient);
    }

    return (repositories: repos, localizedClients: localizedClients);
  }
}
