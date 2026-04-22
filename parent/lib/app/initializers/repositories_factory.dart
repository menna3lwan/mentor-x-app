
import 'package:dio_http_client/dio_http_client.dart';
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

import 'package:parent_mock_authentication_repository/parent_mock_authentication_repository.dart';
import 'package:parent_mock_home_repository/parent_mock_home_repository.dart';
import 'package:parent_mock_children_repository/parent_mock_children_repository.dart';
import 'package:parent_mock_financial_repository/parent_mock_financial_repository.dart';
import 'package:parent_mock_course_repository/parent_mock_course_repository.dart';
import 'package:parent_mock_attendance_repository/parent_mock_attendance_repository.dart';
import 'package:parent_mock_grade_repository/parent_mock_grade_repository.dart';
import 'package:parent_mock_communication_repository/parent_mock_communication_repository.dart';

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
      RepositoryProvider<ParentCourseRepository>(create: (_) => courseRepository),
      RepositoryProvider<ParentAttendanceRepository>(
        create: (_) => attendanceRepository,
      ),
      RepositoryProvider<ParentGradeRepository>(create: (_) => gradeRepository),
      RepositoryProvider<ParentCommunicationRepository>(
        create: (_) => communicationRepository,
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

  static Future<AuthenticationRepository<ParentEntity>> _initAuthenticationRepository() async {
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
    switch (Env.homeRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentHomeRepository(); // Assuming it matches the name in its package
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        final cacheRepository = await _initCacheRepository();
        return DioParentHomeRepository(
          httpClient: httpClient,
          cacheRepository: cacheRepository,
        );
    }
  }

  static Future<ParentChildrenRepository> _initChildrenRepository() async {
    switch (Env.childrenRepositoryMode) {
      case RepositoryMode.mock:
        return MockChildrenRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        final cacheRepository = await _initCacheRepository();
        return DioParentChildrenRepository(
          httpClient: httpClient,
          cacheRepository: cacheRepository,
        );
    }
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

  static Future<ParentCommunicationRepository> _initCommunicationRepository() async {
    switch (Env.communicationRepositoryMode) {
      case RepositoryMode.mock:
        return MockParentCommunicationRepository(delay: Env.mockDelayDuration);
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        return DioParentCommunicationRepository(httpClient: httpClient);
    }
  }

  static String _defaultLanguageCode() {
    // In a real app, you'd use a locale setting package like student app does
    // For now, simpler implementation or fallback
    return Env.defaultLanguageCode;
  }

  static Future<
      ({AppRepositories repositories, List<LocalizedClient> localizedClients})>
      initRepositories() async {
    if (Env.usesAnyProdRepository && !Env.hasMentorXBaseUrl) {
      throw StateError(
        'MENTORX_API_BASE_URL must be provided when any repository mode is PROD.',
      );
    }

    final CacheRepository cacheRepository = await _initCacheRepository();
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
    );

    final localizedClients = <LocalizedClient>[];
    if (_httpClient != null && _httpClient is LocalizedClient) {
      localizedClients.add(_httpClient! as LocalizedClient);
    }

    return (repositories: repos, localizedClients: localizedClients);
  }
}
