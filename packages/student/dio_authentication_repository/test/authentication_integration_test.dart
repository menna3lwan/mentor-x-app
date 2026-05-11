import 'package:test/test.dart';
import 'package:dio_authentication_repository/dio_authentication_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

void main() {
  late StudentAuthenticationRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioAuthenticationRepository(
      httpClient: httpClient,
      cacheRepository: cacheRepository,
    );
    await repository.initialize();
  });

  group('Authentication Integration Tests', () {
    test('Login Success with valid credentials', () async {
      final user = await repository.loginWithPassword(
        phoneNumber: IntegrationConfig.testPhoneNumber,
        password: IntegrationConfig.testPassword,
      );

      expect(user, isA<StudentEntity>());
      expect(user.phoneNumber, equals(IntegrationConfig.testPhoneNumber));
      
      // Verify token was cached
      final cachedToken = await cacheRepository.get(CacheKeys.accessToken);
      expect(cachedToken, isNotNull);
      expect(cachedToken, isNotEmpty);
    });

    test('Login Failure with invalid credentials', () async {
      try {
        await repository.loginWithPassword(
          phoneNumber: '01000000001', // Invalid phone
          password: 'wrong_password',
        );
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<AuthenticationRepositoryException>());
        // The current repo might return failedToGetCurrentUser or unknown on failure
        // Depending on how DioHttpClient maps 401
      }
    });

    test('Check Phone registration status', () async {
      final status = await repository.checkPhone(IntegrationConfig.testPhoneNumber);
      expect(status, isA<bool>());
    });

    test('Get Entry Point', () async {
      final entryPoint = await repository.getEntryPoint();
      expect(entryPoint, isA<String>());
    });

    test('Logout clears cache', () async {
      // First login
      await repository.loginWithPassword(
        phoneNumber: IntegrationConfig.testPhoneNumber,
        password: IntegrationConfig.testPassword,
      );
      
      expect(await cacheRepository.get(CacheKeys.accessToken), isNotNull);

      // Logout
      await repository.logout();
      
      expect(await cacheRepository.get(CacheKeys.accessToken), isNull);
      expect(httpClient.isAuthenticated, isFalse);
    });
  });
}
