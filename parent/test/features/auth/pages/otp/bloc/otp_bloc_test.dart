import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/otp/bloc/otp_bloc.dart';
import 'package:parent_core/parent_core.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  late MockAuthRepository authRepository;

  const tPhone = '01000000000';
  const tCode = '123456';
  const tUser = ParentEntity(
    id: 'user-1',
    name: 'Test Parent',
    phoneNumber: tPhone,
  );
  const tAuthException = AuthenticationException(
    code: AuthenticationExceptionCode.invalidOtp,
    message: 'Invalid OTP code',
  );

  setUp(() {
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
        when(() => authRepository.verifyOtp(tPhone, tCode))
            .thenAnswer((_) async => tUser);
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
        when(() => authRepository.verifyOtp(tPhone, tCode))
            .thenAnswer((_) async => tUser);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: tCode)),
      expectPresentation: () => [
        isA<OtpSuccessPresentationEvent>()
            .having((e) => e.user, 'user', tUser),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] on AuthenticationException',
      build: () {
        when(() => authRepository.verifyOtp(tPhone, any()))
            .thenThrow(tAuthException);
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
        when(() => authRepository.verifyOtp(tPhone, any()))
            .thenThrow(tAuthException);
        return OtpBloc(authenticationRepository: authRepository);
      },
      act: (bloc) =>
          bloc.add(const OtpSubmittedEvent(phone: tPhone, code: '000000')),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>()
            .having((e) => e.exception, 'exception', tAuthException),
      ],
    );

    blocTest<OtpBloc, OtpState>(
      'emits [loading, failure] with unknown code on unexpected exception',
      build: () {
        when(() => authRepository.verifyOtp(any(), any()))
            .thenThrow(Exception('server error'));
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
  });
}
