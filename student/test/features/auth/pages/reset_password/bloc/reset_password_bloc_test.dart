import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_student/features/auth/pages/reset_password/bloc/reset_password_bloc.dart';

class MockStudentAuthenticationRepository extends Mock
    implements StudentAuthenticationRepository {}

void main() {
  late StudentAuthenticationRepository authRepository;
  const testPhone = '01234567890';

  setUp(() {
    authRepository = MockStudentAuthenticationRepository();
  });

  group('ResetPasswordBloc', () {
    test('initial state is correct', () {
      final bloc = ResetPasswordBloc(
        authRepository: authRepository,
        phoneNumber: testPhone,
      );
      expect(bloc.state, const ResetPasswordState(phoneNumber: testPhone));
      bloc.close();
    });

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits updated values when events are added',
      build: () => ResetPasswordBloc(
        authRepository: authRepository,
        phoneNumber: testPhone,
      ),
      act: (bloc) => bloc
        ..add(const ResetPasswordOtpChanged('123456'))
        ..add(const ResetPasswordNewPasswordChanged('password123'))
        ..add(const ResetPasswordConfirmPasswordChanged('password123')),
      expect: () => [
        const ResetPasswordState(phoneNumber: testPhone, otp: '123456'),
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
        ),
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
          confirmPassword: 'password123',
        ),
      ],
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits success when ResetPasswordSubmitted is successful',
      build: () {
        when(() => authRepository.resetPassword(
              phoneNumber: any(named: 'phoneNumber'),
              otp: any(named: 'otp'),
              newPassword: any(named: 'newPassword'),
            )).thenAnswer((_) async {});
        return ResetPasswordBloc(
          authRepository: authRepository,
          phoneNumber: testPhone,
        );
      },
      act: (bloc) => bloc
        ..add(const ResetPasswordOtpChanged('123456'))
        ..add(const ResetPasswordNewPasswordChanged('password123'))
        ..add(const ResetPasswordConfirmPasswordChanged('password123'))
        ..add(const ResetPasswordSubmitted()),
      skip: 3,
      expect: () => [
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
          confirmPassword: 'password123',
          loadingState: LoadingState.loading,
        ),
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
          confirmPassword: 'password123',
          loadingState: LoadingState.loaded,
        ),
      ],
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits failure when passwords do not match',
      build: () => ResetPasswordBloc(
        authRepository: authRepository,
        phoneNumber: testPhone,
      ),
      act: (bloc) => bloc
        ..add(const ResetPasswordOtpChanged('123456'))
        ..add(const ResetPasswordNewPasswordChanged('password123'))
        ..add(const ResetPasswordConfirmPasswordChanged('wrongpassword'))
        ..add(const ResetPasswordSubmitted()),
      skip: 3,
      expect: () => [], // No state change on submission if validation fails
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      'emits failure when repository throws exception',
      build: () {
        when(() => authRepository.resetPassword(
              phoneNumber: any(named: 'phoneNumber'),
              otp: any(named: 'otp'),
              newPassword: any(named: 'newPassword'),
            )).thenThrow(AuthenticationRepositoryException(
          code: AuthenticationRepositoryExceptionCode.unknown,
          message: 'Reset failed',
        ));
        return ResetPasswordBloc(
          authRepository: authRepository,
          phoneNumber: testPhone,
        );
      },
      act: (bloc) => bloc
        ..add(const ResetPasswordOtpChanged('123456'))
        ..add(const ResetPasswordNewPasswordChanged('password123'))
        ..add(const ResetPasswordConfirmPasswordChanged('password123'))
        ..add(const ResetPasswordSubmitted()),
      skip: 3,
      expect: () => [
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
          confirmPassword: 'password123',
          loadingState: LoadingState.loading,
        ),
        const ResetPasswordState(
          phoneNumber: testPhone,
          otp: '123456',
          newPassword: 'password123',
          confirmPassword: 'password123',
          loadingState: LoadingState.error,
          errorMessage: 'Reset failed',
        ),
      ],
    );
  });
}
