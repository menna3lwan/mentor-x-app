import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_authentication_repository/mock_authentication_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MockAuthenticationRepository', () {
    test(
      'requestPasswordReset completes when initialized with valid phone',
      () async {
        final repository = MockAuthenticationRepository(delay: Duration.zero);
        await repository.initialize();

        await expectLater(
          repository.requestPasswordReset('01012345678'),
          completes,
        );
      },
    );

    test(
      'requestPasswordReset throws invalidPhoneNumber for empty phone',
      () async {
        final repository = MockAuthenticationRepository(delay: Duration.zero);
        await repository.initialize();

        expect(
          () => repository.requestPasswordReset('  '),
          throwsA(
            isA<AuthenticationRepositoryException>().having(
              (e) => e.code,
              'code',
              AuthenticationRepositoryExceptionCode.invalidPhoneNumber,
            ),
          ),
        );
      },
    );

    test(
      'requestPasswordReset throws unknown when repository is uninitialized',
      () async {
        final repository = MockAuthenticationRepository(delay: Duration.zero);

        expect(
          () => repository.requestPasswordReset('01012345678'),
          throwsA(
            isA<AuthenticationRepositoryException>().having(
              (e) => e.code,
              'code',
              AuthenticationRepositoryExceptionCode.unknown,
            ),
          ),
        );
      },
    );

    test('resetPassword completes with matching phone and OTP', () async {
      final repository = MockAuthenticationRepository(delay: Duration.zero);
      await repository.initialize();
      await repository.requestPasswordReset('01012345678');

      await expectLater(
        repository.resetPassword(
          phoneNumber: '01012345678',
          otp: '000000',
          newPassword: 'Secure@Pass1',
        ),
        completes,
      );
    });

    test('resetPassword throws invalidOtp when otp does not match', () async {
      final repository = MockAuthenticationRepository(delay: Duration.zero);
      await repository.initialize();
      await repository.requestPasswordReset('01012345678');

      expect(
        () => repository.resetPassword(
          phoneNumber: '01012345678',
          otp: '123456',
          newPassword: 'Secure@Pass1',
        ),
        throwsA(
          isA<AuthenticationRepositoryException>().having(
            (e) => e.code,
            'code',
            AuthenticationRepositoryExceptionCode.invalidOtp,
          ),
        ),
      );
    });
  });
}
