import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/forget_password/bloc/forget_password_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  late MockAuthRepository authRepository;

  const tPhone = '01000000000';
  const tAuthException = AuthenticationException(
    code: AuthenticationExceptionCode.networkError,
    message: 'Network error',
  );

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('ForgetPasswordBloc', () {
    test('initial state is ForgetPasswordState.initial', () {
      final bloc = ForgetPasswordBloc(authenticationRepository: authRepository);
      expect(bloc.state, ForgetPasswordState.initial);
      bloc.close();
    });

    blocTest<ForgetPasswordBloc, ForgetPasswordState>(
      'emits [loading, success] on successful OTP send',
      build: () {
        when(
          () => authRepository.requestPasswordReset(tPhone),
        ).thenAnswer((_) async {});
        return ForgetPasswordBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordSubmittedEvent(phoneNumber: tPhone),
      ),
      expect: () => [
        ForgetPasswordState.initial.copyWith(
          loadingState: ForgetPasswordLoadingState.loading,
        ),
        ForgetPasswordState.initial.copyWith(
          loadingState: ForgetPasswordLoadingState.success,
        ),
      ],
      verify: (_) {
        verify(() => authRepository.requestPasswordReset(tPhone)).called(1);
      },
    );

    blocPresentationTest<
      ForgetPasswordBloc,
      ForgetPasswordState,
      ForgetPasswordPresentationEvent
    >(
      'emits ForgetPasswordSuccessPresentationEvent with phone on success',
      build: () {
        when(
          () => authRepository.requestPasswordReset(tPhone),
        ).thenAnswer((_) async {});
        return ForgetPasswordBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordSubmittedEvent(phoneNumber: tPhone),
      ),
      expectPresentation: () => [
        isA<ForgetPasswordSuccessPresentationEvent>().having(
          (e) => e.phone,
          'phone',
          tPhone,
        ),
      ],
    );

    blocTest<ForgetPasswordBloc, ForgetPasswordState>(
      'emits [loading, failure] on AuthenticationException',
      build: () {
        when(
          () => authRepository.requestPasswordReset(any()),
        ).thenThrow(tAuthException);
        return ForgetPasswordBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordSubmittedEvent(phoneNumber: tPhone),
      ),
      expect: () => [
        ForgetPasswordState.initial.copyWith(
          loadingState: ForgetPasswordLoadingState.loading,
        ),
        ForgetPasswordState.initial.copyWith(
          loadingState: ForgetPasswordLoadingState.failure,
          exception: tAuthException,
        ),
      ],
    );

    blocPresentationTest<
      ForgetPasswordBloc,
      ForgetPasswordState,
      ForgetPasswordPresentationEvent
    >(
      'emits ForgetPasswordFailurePresentationEvent on AuthenticationException',
      build: () {
        when(
          () => authRepository.requestPasswordReset(any()),
        ).thenThrow(tAuthException);
        return ForgetPasswordBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(
        const ForgetPasswordSubmittedEvent(phoneNumber: tPhone),
      ),
      expectPresentation: () => [
        isA<ForgetPasswordFailurePresentationEvent>().having(
          (e) => e.exception,
          'exception',
          tAuthException,
        ),
      ],
    );
  });
}
