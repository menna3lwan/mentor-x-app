import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_authentication_repository/mock_authentication_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/otp_page/bloc/otp_page_bloc.dart';

void main() {
  late MockAuthenticationRepository authRepository;

  const testPhone = '0501234567';
  const validOtp = '000000';
  const invalidOtp = '111111';

  setUp(() async {
    authRepository = MockAuthenticationRepository(delay: Duration.zero);
    await authRepository.initialize();
    // sendOtp sets _validOtp = '000000' and stores the phone number
    await authRepository.sendOtp(testPhone);
  });

  OtpPageBloc buildBloc() => OtpPageBloc(
    authRepository: authRepository,
    phoneNumber: testPhone,
    otpLength: 6,
    otpDuration: Duration.zero,
  );

  group('OtpPageBloc', () {
    // ──── 1. Initial state ────
    test('initial state is correct', () {
      final bloc = buildBloc();

      expect(bloc.state.phoneNumber, testPhone);
      expect(bloc.state.otp, '');
      expect(bloc.state.otpLength, 6);
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.resendCountdown, 0);
      expect(bloc.state.isResending, false);

      bloc.close();
    });

    // ──── 2. OtpChanged updates otp ────
    blocTest<OtpPageBloc, OtpPageState>(
      'emits state with updated otp when OtpChanged is added',
      build: buildBloc,
      act: (bloc) => bloc.add(const OtpPageOtpChanged('123')),
      expect: () => [
        isA<OtpPageState>()
            .having((s) => s.otp, 'otp', '123')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            ),
      ],
    );

    // ──── 3. OtpChanged clears previous error ────
    blocTest<OtpPageBloc, OtpPageState>(
      'OtpChanged clears previous error',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '111111',
        otpLength: 6,
        loadingState: LoadingState.error,
        errorMessage: 'Invalid OTP provided',
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageOtpChanged('000')),
      expect: () => [
        isA<OtpPageState>()
            .having((s) => s.otp, 'otp', '000')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    // ──── 4. Submit with wrong length OTP does nothing ────
    blocTest<OtpPageBloc, OtpPageState>(
      'does nothing when submitted with wrong length OTP',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '123',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageSubmitted()),
      expect: () => <OtpPageState>[],
    );

    // ──── 5. Submit with correct OTP -> loading, loaded ────
    blocTest<OtpPageBloc, OtpPageState>(
      'emits [loading, loaded] when submitted with correct OTP',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: validOtp,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageSubmitted()),
      expect: () => [
        isA<OtpPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<OtpPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ──── 6. Submit with invalid OTP -> loading, error ────
    blocTest<OtpPageBloc, OtpPageState>(
      'emits [loading, error] when submitted with invalid OTP',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: invalidOtp,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageSubmitted()),
      expect: () => [
        isA<OtpPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<OtpPageState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.error,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Invalid OTP provided',
            ),
      ],
    );

    // ──── 7. Resend blocked when countdown > 0 ────
    blocTest<OtpPageBloc, OtpPageState>(
      'resend is blocked when countdown > 0',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 30,
      ),
      act: (bloc) => bloc.add(const OtpPageResendRequested()),
      expect: () => <OtpPageState>[],
    );

    // ──── 8. Resend succeeds when countdown is 0 ────
    blocTest<OtpPageBloc, OtpPageState>(
      'resend succeeds when countdown is 0',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageResendRequested()),
      expect: () => [
        // First emission: isResending becomes true
        isA<OtpPageState>().having((s) => s.isResending, 'isResending', true),
        // Second emission: isResending false, countdown resets to 10
        // (MockDataConfig.resendOtpDuration = Duration(seconds: 10))
        isA<OtpPageState>()
            .having((s) => s.isResending, 'isResending', false)
            .having((s) => s.resendCountdown, 'resendCountdown', 10),
      ],
    );

    // ──── 9. Countdown tick decrements resendCountdown ────
    blocTest<OtpPageBloc, OtpPageState>(
      'countdown tick decrements resendCountdown',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 3,
      ),
      act: (bloc) => bloc.add(const OtpPageCountdownTicked()),
      expect: () => [
        isA<OtpPageState>().having(
          (s) => s.resendCountdown,
          'resendCountdown',
          2,
        ),
      ],
    );

    // ──── 10. Countdown stops at 0 ────
    blocTest<OtpPageBloc, OtpPageState>(
      'countdown stops at 0 and emits nothing',
      build: buildBloc,
      seed: () => const OtpPageState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpPageCountdownTicked()),
      expect: () => <OtpPageState>[],
    );
  });
}
