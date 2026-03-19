import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter_secure_storage_cache_repository/flutter_secure_storage_cache_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';

import 'package:parent_core/parent_core.dart';
import 'package:parent_authentication_repository/dio_authentication_repository.dart';
import 'package:parent_mock_authentication_repository/mock_authentication_repository.dart';

import '../../core/utils/env.dart';

// ────────────────────────────────────────────────────────────────────────────
// AppRepositories — typed container for every initialized repository.
// ────────────────────────────────────────────────────────────────────────────

final class AppRepositories {
  final CacheRepository cacheRepository;
  final AuthenticationRepository authenticationRepository;

  const AppRepositories._({
    required this.cacheRepository,
    required this.authenticationRepository,
  });

  /// Flat list — useful for parallel teardown/iteration.
  List<Object> toList() => [cacheRepository, authenticationRepository];

  /// [RepositoryProvider] list for [MultiRepositoryProvider].
  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<CacheRepository>(create: (_) => cacheRepository),
      RepositoryProvider<AuthenticationRepository>(
        create: (_) => authenticationRepository,
      ),
    ];
  }
}

// ────────────────────────────────────────────────────────────────────────────
// RepositoriesFactory — lazy-singleton wiring with mock / prod switch.
// ────────────────────────────────────────────────────────────────────────────

final class RepositoriesFactory {
  RepositoriesFactory._();

  // ── Singleton instances ──────────────────────────────────────────────────
  static HttpClient? _httpClient;
  static bool _httpClientInitialized = false;
  static CacheRepository? _cacheRepository;

  /// Language code resolved on first [initRepositories] call.
  static late final String initialLanguageCode;

  // ── Lazy singleton initializers ──────────────────────────────────────────

  static Future<CacheRepository> _initCacheRepository() async {
    if (_cacheRepository != null) return _cacheRepository!;
    final repo = FlutterSecureStorageCacheRepository();
    await repo.initialize();
    _cacheRepository = repo;
    return repo;
  }

  static Future<HttpClient> _initHttpClient() async {
    if (_httpClientInitialized && _httpClient != null) return _httpClient!;
    final cacheRepository = await _initCacheRepository();
    final client = DioHttpClient(
      baseUrl: Env.mentorxBaseUrl,
      cacheRepository: cacheRepository,
    );
    _httpClient = client;
    _httpClientInitialized = true;
    return client;
  }

  static Future<CacheRepository> get cacheRepository async => await _initCacheRepository();

  // ── Per-repository initializers ──────────────────────────────────────────

  static Future<AuthenticationRepository>
  _initAuthenticationRepository() async {
    late final AuthenticationRepository repo;
    switch (Env.authenticationRepositoryMode) {
      case RepositoryMode.mock:
        repo = MockAuthenticationRepository(
          delay: Env.mockDelayDuration,
          mockPhone: Env.mockUserPhone,
          mockOtp: Env.mockOtpCode,
          mockUserName: Env.mockUserName,
        );
      case RepositoryMode.prod:
        final httpClient = await _initHttpClient();
        repo = DioAuthenticationRepository(
          httpClient: httpClient,
          cacheRepository: await cacheRepository,
        );
    }
    await repo.initialize();
    return repo;
  }

  // ── Language detection ────────────────────────────────────────────────────

  static Future<String> _resolveLanguageCode(
    CacheRepository cacheRepository,
  ) async {
    return await cacheRepository.get(CacheKeys.languageCode) ??
        Env.defaultLanguageCode;
  }

  // ── Main entry point ──────────────────────────────────────────────────────

  static Future<AppRepositories> initRepositories() async {
    // CacheRepository MUST be first — all others may depend on it.
    final cacheRepository = await _initCacheRepository();
    initialLanguageCode = await _resolveLanguageCode(cacheRepository);

    // Initialize remaining repositories in parallel.
    final results = await Future.wait([
      _initAuthenticationRepository(),
    ]);

    return AppRepositories._(
      cacheRepository: cacheRepository,
      authenticationRepository: results[0],
    );
  }
}
