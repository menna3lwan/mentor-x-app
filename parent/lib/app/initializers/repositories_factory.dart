import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';

import 'package:parent_core/parent_core.dart';
import 'package:parent_authentication_repository/dio_authentication_repository.dart';
import 'package:parent_mock_authentication_repository/mock_authentication_repository.dart';

import '../../core/utils/env.dart';

final class AppRepositories {
  final CacheRepository cacheRepository;
  final AuthenticationRepository authenticationRepository;

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
  });

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<AuthenticationRepository>(
        create: (_) => authenticationRepository,
      ),
    ];
  }
}

final class RepositoriesFactory {
  RepositoriesFactory._();

  static HttpClient? _httpClient;
  static CacheRepository? _cacheRepository;
  static late final String initialLanguageCode;

  static Future<CacheRepository> _initCacheRepository() async {
    if (_cacheRepository != null) return _cacheRepository!;
    final CacheRepository cacheRepository =
        FlutterSecureStorageCacheRepository();
    await cacheRepository.initialize();
    _cacheRepository = cacheRepository;
    return cacheRepository;
  }

  static Future<HttpClient> _initHttpClient() async {
    if (_httpClient != null) return _httpClient!;
    final cacheRepository = await _initCacheRepository();
    final httpClient = DioHttpClient(
      baseUrl: Env.mentorxBaseUrl,
      cacheRepository: cacheRepository,
    );
    _httpClient = httpClient as HttpClient;
    return _httpClient!;
  }

  static Future<AuthenticationRepository>
      _initAuthenticationRepository() async {
    late final AuthenticationRepository repo;
    switch (Env.authenticationRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockAuthenticationRepository();
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioAuthenticationRepository(client: httpClient as DioHttpClient);
    }
    await repo.initialize();
    return repo;
  }

  static Future<AppRepositories> initRepositories() async {
    final cacheRepository = await _initCacheRepository();

    initialLanguageCode = await cacheRepository.get(CacheKeys.languageCode) ??
        Env.defaultLanguageCode;

    final authenticationRepository = await _initAuthenticationRepository();

    return AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: authenticationRepository,
    );
  }
}
