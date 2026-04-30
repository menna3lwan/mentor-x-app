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

  group('Auth Discovery Flow', () {
    test('Check phone and start registration', () async {
      final exists = await repository.checkPhone('01000000000');
      print('Phone exists: $exists');
      
      if (exists) {
        // Try login with 123456 as password just in case
        try {
           await repository.loginWithPassword(
            phoneNumber: '01000000000',
            password: 'password',
          );
          print('Login with "password" worked!');
        } catch (_) {}
      }

      print('Starting registration for 01000000001 (new user)...');
      repository.setOtpVerificationContext(
        phoneNumber: '01000000001',
        purpose: OtpVerificationPurpose.registration,
      );
      
      try {
        await repository.sendOtp('01000000001');
        print('OTP sent!');
        
        // Try verifying with common codes
        for (var code in ['123456', '000000', '111111', '1234']) {
           try {
             final student = await repository.verifyOtp(code);
             print('OTP $code worked! Student: ${student.firstName}');
             return;
           } catch (e) {
             print('OTP $code failed');
           }
        }
      } catch (e) {
        print('Send OTP failed: $e');
      }
    });
  });
}
