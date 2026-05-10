import 'package:test/test.dart';
import 'package:dio_student_registration_repository/dio_student_registration_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

/// Integration tests that verify [DioStudentRegistrationRepository]
/// against the live backend API.
///
/// Run with:
/// ```bash
/// dart test test/registration_integration_test.dart
/// ```
void main() {
  late DioStudentRegistrationRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    httpClient.setDefaultHeader('X-Tenant-Id', '1');
    httpClient.setDefaultHeader(NetworkConstants.deviceIdHeader, 'student-app');
    repository = DioStudentRegistrationRepository(httpClient: httpClient);
  });

  group('Registration Integration Tests', () {
    // ── 1. Application Info ─────────────────────────────────────────────
    test('getApplicationInfo returns valid data', () async {
      final info = await repository.getApplicationInfo();

      expect(info, isA<StudentApplicationInfoEntity>());
      expect(info.grades, isNotEmpty);
    });

    // ── 2. Governorates ─────────────────────────────────────────────────
    test('getGovernorates returns non-empty list', () async {
      final governorates = await repository.getGovernorates();

      expect(governorates, isNotEmpty);
      expect(governorates.first, isA<GovernorateEntity>());
      expect(governorates.first.id, isNotEmpty);
      expect(governorates.first.name, isNotEmpty);
    });

    // ── 3. Areas for Governorate ────────────────────────────────────────
    test('getAreas returns areas for a valid governorate', () async {
      final governorates = await repository.getGovernorates();
      expect(governorates, isNotEmpty, reason: 'Need at least one governorate');

      final areas = await repository.getAreas(governorates.first.id);

      expect(areas, isA<List<String>>());
      expect(areas, isNotEmpty);
    });

    // ── 4. Check Phone ─────────────────────────────────────────────────
    test('checkPhone returns bool for known number', () async {
      final result = await repository.checkPhone(IntegrationConfig.testPhoneNumber);

      expect(result, isA<bool>());
    });

    test('checkPhone returns true for a fresh number', () async {
      // Use a random unregistered number
      final result = await repository.checkPhone('01599999999');

      expect(result, isTrue);
    });

    // ── 5. Start Registration ───────────────────────────────────────────
    test('startRegistration completes without error for valid phone', () async {
      // Note: this will actually send an OTP to this number on the backend.
      // Using the known test phone that the backend accepts.
      await expectLater(
        repository.startRegistration(phone: IntegrationConfig.testPhoneNumber),
        completes,
      );
    });

    test('startRegistration throws on invalid phone', () async {
      await expectLater(
        repository.startRegistration(phone: ''),
        throwsA(isA<StudentRegistrationException>()),
      );
    });

    // ── 6. Verify OTP ──────────────────────────────────────────────────
    test('verifyOtp throws on invalid OTP code', () async {
      await expectLater(
        repository.verifyOtp(
          phone: IntegrationConfig.testPhoneNumber,
          otp: '000000', // intentionally wrong
        ),
        throwsA(isA<StudentRegistrationException>()),
      );
    });

    // ── 7. Resend OTP ──────────────────────────────────────────────────
    test('resendOtp completes for valid phone', () async {
      // Must start registration first
      try {
        await repository.startRegistration(
          phone: IntegrationConfig.testPhoneNumber,
        );
      } catch (_) {
        // May already be started — continue
      }

      await expectLater(
        repository.resendOtp(IntegrationConfig.testPhoneNumber),
        completes,
      );
    });

    // ── 8. Complete Registration Validation ─────────────────────────────
    test('completeRegistration throws on invalid/missing data', () async {
      await expectLater(
        repository.completeRegistration(
          firstName: '',
          secondName: '',
          thirdName: '',
          fourthName: '',
          governorateId: '',
          area: '',
          gradeId: '',
          online: false,
          otp: '000000',
          parentPhone: '',
          phone: '',
          password: '',
          confirmPassword: '',
        ),
        throwsA(isA<StudentRegistrationException>()),
      );
    });
  });
}
