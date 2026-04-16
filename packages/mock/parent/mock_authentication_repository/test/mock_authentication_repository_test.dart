import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:parent_mock_authentication_repository/mock_authentication_repository.dart';

void main() {
  group('MockAuthenticationRepository', () {
    late MockAuthenticationRepository repository;

    const phone = '01000000000';
    const otp = '123456';

    setUp(() {
      repository = MockAuthenticationRepository(delay: Duration.zero);
    });

    test('resendOtp returns cooldown duration', () async {
      final duration = await repository.resendOtp(phone);
      expect(duration, const Duration(seconds: 60));
    });

    test('requestPasswordReset succeeds for configured phone', () async {
      await repository.requestPasswordReset(phone);
    });

    test('requestPasswordReset throws for unknown phone', () async {
      await expectLater(
        () => repository.requestPasswordReset('01111111111'),
        throwsA(
          isA<AuthenticationException>().having(
            (e) => e.code,
            'code',
            AuthenticationExceptionCode.failedToRequestPasswordReset,
          ),
        ),
      );
    });

    test('resetPassword succeeds after password reset request', () async {
      await repository.requestPasswordReset(phone);

      await repository.resetPassword(
        phone: phone,
        otp: otp,
        newPassword: 'StrongPass1!',
      );
    });

    test('resetPassword throws for invalid OTP', () async {
      await repository.requestPasswordReset(phone);

      await expectLater(
        () => repository.resetPassword(
          phone: phone,
          otp: '000000',
          newPassword: 'StrongPass1!',
        ),
        throwsA(
          isA<AuthenticationException>().having(
            (e) => e.code,
            'code',
            AuthenticationExceptionCode.invalidOtp,
          ),
        ),
      );
    });
  });
}
