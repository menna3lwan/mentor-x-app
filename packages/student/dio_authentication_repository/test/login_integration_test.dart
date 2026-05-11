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
  });

  group('Login Integration Test', () {
    test('Login with registered credentials', () async {
      try {
        final student = await repository.loginWithPassword(
          phoneNumber: IntegrationConfig.testPhoneNumber,
          password: IntegrationConfig.testPassword,
        );
        print('Login successful for: ${student.firstName}');
        
        final token = await cacheRepository.get('token');
        print('Token in cache: ${token != null ? "PRESENT" : "MISSING"}');
        if (token != null) {
          print('Token starts with: ${token.substring(0, 10)}...');
        }
      } on AccountPendingException catch (e) {
        print('Account is PENDING (as expected): ${e.message}');
        print('Support WhatsApp: ${e.supportWhatsApp}');
      } on AuthenticationRepositoryException catch (e) {
        print('Login failed: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });
  });
}
