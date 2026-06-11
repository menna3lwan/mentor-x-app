import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/otp/bloc/otp_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository<ParentEntity> {}

void main() {
  late MockAuthRepository authRepository;

  const tPhone = '01000000000';
  const tCode = '123456';
  const tResendDuration = Duration(seconds: 45);
  final tUser = ParentEntity(
    id: 'user-1',
    firstName: 'Test',
    lastName: 'Parent',
    email: 'test@parent.com',
    phoneNumber: tPhone,
    status: ParentStatus.active,
    createdAt: DateTime(2023),
    updatedAt: DateTime(2023),
  );
  const tAuthException = AuthenticationException(
    code: AuthenticationExceptionCode.invalidOtp,
    message: 'Invalid OTP code',
  );

  setUp(() {
    print('DEBUG: ParentStatus.active.name is: ${ParentStatus.active.name}');
    authRepository = MockAuthRepository();
  });

  group('OtpBloc', () {
    test('initial state is OtpState.initial', () {
      final bloc = OtpBloc(authenticationRepository: authRepository);
      expect(bloc.state, OtpState.initial);
      bloc.close();
    });

    blocTest<OtpBloc, OtpState>(
      'emits [loading, success] on successful OTP verification',
      build: () {
        when(
          () => authRepository.verifyOtp(tPhone, tCode),
        ).thenAnswer((_) async => tUser);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: tCode)),
      expect: () => [
        OtpState.initial.copyWith(loadingState: OtpLoadingState.loading),
        OtpState.initial.copyWith(loadingState: OtpLoadingState.success),
      ],
      verify: (_) {
        verify(() => authRepository.verifyOtp(tPhone, tCode)).called(1);
      },
    );

    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpSuccessPresentationEvent on successful OTP verification',
      build: () {
        when(
          () => authRepository.verifyOtp(tPhone, tCode),
        ).thenAnswer((_) async => tUser);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: tCode)),
      expectPresentation: () => [
        isA<OtpSuccessPresentationEvent>().having((e) => e.user, 'user', tUser),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] on AuthenticationException',
      build: () {
        when(
          () => authRepository.verifyOtp(tPhone, any()),
        ).thenThrow(tAuthException);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: '000000')),
      expect: () => [
        OtpState.initial.copyWith(loadingState: OtpLoadingState.loading),
        OtpState.initial.copyWith(
          loadingState: OtpLoadingState.failure,
          exception: tAuthException,
        ),
      ],
    );

    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpFailurePresentationEvent on AuthenticationException',
      build: () {
        when(
          () => authRepository.verifyOtp(tPhone, any()),
        ).thenThrow(tAuthException);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: '000000')),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>().having(
          (e) => e.exception,
          'exception',
          tAuthException,
        ),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] with unknown code on unexpected exception',
      build: () {
        when(
          () => authRepository.verifyOtp(any(), any()),
        ).thenThrow(Exception('server error'));
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: tCode)),
      expect: () => [
        OtpState.initial.copyWith(loadingState: OtpLoadingState.loading),
        OtpState.initial.copyWith(
          loadingState: OtpLoadingState.failure,
          exception: const AuthenticationException(
            code: AuthenticationExceptionCode.unknown,
          ),
        ),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'decrements resend countdown when tick event is received',
      build: () => OtpBloc(
        authenticationRepository: authRepository,
        initialResendCountdown: 2,
      ),
      act: (bloc) => bloc.add(const OtpCountdownTicked()),
      expect: () => [
        OtpState.initial.copyWith(resendCountdown: 1),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits resend loading then cooldown update on successful resend',
      build: () {
        when(
          () => authRepository.resendOtp(tPhone),
        ).thenAnswer((_) async => tResendDuration);
        return OtpBloc(
          authenticationRepository: authRepository,
          initialResendCountdown: 0,
        );
      },
      act: (bloc) => bloc.add(const OtpResendRequested(phone: tPhone)),
      expect: () => [
        OtpState.initial.copyWith(resendCountdown: 0, isResending: true),
        OtpState.initial.copyWith(
          resendCountdown: tResendDuration.inSeconds,
          isResending: false,
        ),
      ],
      verify: (_) {
        verify(() => authRepository.resendOtp(tPhone)).called(1);
      },
    );

    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpFailurePresentationEvent when resend fails',
      build: () {
        when(() => authRepository.resendOtp(tPhone)).thenThrow(
          const AuthenticationException(
            code: AuthenticationExceptionCode.failedToResendOtp,
            message: 'Unable to resend',
          ),
        );
        return OtpBloc(
          authenticationRepository: authRepository,
          initialResendCountdown: 0,
        );
      },
      act: (bloc) => bloc.add(const OtpResendRequested(phone: tPhone)),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>().having(
          (e) => e.exception,
          'exception',
          const AuthenticationException(
            code: AuthenticationExceptionCode.failedToResendOtp,
            message: 'Unable to resend',
          ),
        ),
      ],
    );
  });
}
