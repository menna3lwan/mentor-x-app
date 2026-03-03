import 'dart:ui';

import 'package:student_authentication_repository/dio_authentication_repository.dart';
import 'package:student_home_repository/dio_home_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

import 'package:student_mock_authentication_repository/mock_authentication_repository.dart';
import 'package:mock_home_repository/mock_home_repository.dart';

import '../../core/utils/env.dart';

final class AppRepositories {
  final CacheRepository cacheRepository;
  final StudentAuthenticationRepository authenticationRepository;
  final StudentHomeRepository homeRepository;

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
    required this.homeRepository,
  });

  List<Object> toList() {
    return [
      cacheRepository,
      authenticationRepository,
      homeRepository,
    ];
  }

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<StudentAuthenticationRepository>(
        create: (_) => authenticationRepository,
      ),
      RepositoryProvider<StudentHomeRepository>(create: (_) => homeRepository),
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
        repo = MockAuthenticationRepository(
          // mockOtp: Env.mockOTP,
          // mockUser: Env.mockUser,
          // mockPhoneNumber: Env.mockPhoneNumber,
          delay: Env.mockDelayDuration,
        );
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

  static String _defaultLanguageCode() {
    final deviceLanguageCode = PlatformDispatcher.instance.locale.languageCode;
    final supportedLocales = LocaleSettings.instance.supportedLocalesRaw;
    return supportedLocales.contains(deviceLanguageCode)
        ? deviceLanguageCode
        : supportedLocales.contains(Env.defaultLanguageCode)
        ? Env.defaultLanguageCode
        : supportedLocales.first;
  }

  static Future<AppRepositories> initRepositories() async {
    final CacheRepository cacheRepository = await _initCacheRepository();
    initialLanguageCode =
        await cacheRepository.get(
          CacheKeys.languageCode,
        ) ??
        _defaultLanguageCode();

    final [
      authenticationRepository as StudentAuthenticationRepository,
      homeRepository as StudentHomeRepository,
    ] = await Future.wait(
      [
        _initAuthenticationRepository(),
        _initHomeRepository(),
      ],
    );
    final repos = AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: authenticationRepository,
      homeRepository: homeRepository,
    );
    return repos;
  }
}
