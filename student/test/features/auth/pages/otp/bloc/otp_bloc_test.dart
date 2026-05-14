import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_authentication_repository/mock_authentication_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/otp/bloc/otp_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}

void main() {
  late AnalyticsService analyticsService;
  late MockAuthenticationRepository authRepository;
  late MockAuthenticationRepository uninitializedAuthRepository;

  const testPhone = '0501234567';
  const validOtp = '000000';
  const invalidOtp = '111111';

  setUp(() async {
    analyticsService = MockAnalyticsService();
    authRepository = MockAuthenticationRepository(delay: Duration.zero);
    await authRepository.initialize();
    // sendOtp sets _validOtp = '000000' and stores the phone number
    await authRepository.sendOtp(testPhone);

    uninitializedAuthRepository = MockAuthenticationRepository(
      delay: Duration.zero,
    );
  });

  OtpBloc buildBloc() => OtpBloc(
        authRepository: authRepository,
        phoneNumber: testPhone,
        otpLength: 6,
        otpDuration: Duration.zero,
        analyticsService: analyticsService,
      );

  OtpBloc buildUninitializedBloc() => OtpBloc(
        authRepository: uninitializedAuthRepository,
        phoneNumber: testPhone,
        otpLength: 6,
        otpDuration: Duration.zero,
        analyticsService: analyticsService,
      );

  group('OtpBloc', () {
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
    blocTest<OtpBloc, OtpState>(
      'emits state with updated otp when OtpChanged is added',
      build: buildBloc,
      act: (bloc) => bloc.add(const OtpOtpChanged('123')),
      expect: () => [
        isA<OtpState>()
            .having((s) => s.otp, 'otp', '123')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            ),
      ],
    );

    // ──── 3. OtpChanged clears previous error ────
    blocTest<OtpBloc, OtpState>(
      'OtpChanged clears previous error',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '111111',
        otpLength: 6,
        loadingState: LoadingState.error,
        errorMessage: 'Invalid OTP provided',
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpOtpChanged('000')),
      expect: () => [
        isA<OtpState>()
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
    blocTest<OtpBloc, OtpState>(
      'does nothing when submitted with wrong length OTP',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '123',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpSubmitted()),
      expect: () => <OtpState>[],
    );

    // ──── 5. Submit with correct OTP -> loading, loaded ────
    blocTest<OtpBloc, OtpState>(
      'emits [loading, loaded] when submitted with correct OTP',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: validOtp,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpSubmitted()),
      expect: () => [
        isA<OtpState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<OtpState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ──── 6. Submit with invalid OTP -> loading, error ────
    blocTest<OtpBloc, OtpState>(
      'emits [loading, error] when submitted with invalid OTP',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: invalidOtp,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpSubmitted()),
      expect: () => [
        isA<OtpState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<OtpState>()
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
    blocTest<OtpBloc, OtpState>(
      'resend is blocked when countdown > 0',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 30,
      ),
      act: (bloc) => bloc.add(const OtpResendRequested()),
      expect: () => <OtpState>[],
    );

    // ──── 8. Resend succeeds when countdown is 0 ────
    blocTest<OtpBloc, OtpState>(
      'resend succeeds when countdown is 0',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpResendRequested()),
      expect: () => [
        // First emission: isResending becomes true
        isA<OtpState>().having((s) => s.isResending, 'isResending', true),
        // Second emission: isResending false, countdown resets to 10
        // (MockDataConfig.resendOtpDuration = Duration(seconds: 10))
        isA<OtpState>()
            .having((s) => s.isResending, 'isResending', false)
            .having((s) => s.resendCountdown, 'resendCountdown', 10),
      ],
    );

    // ──── 9. Countdown tick decrements resendCountdown ────
    blocTest<OtpBloc, OtpState>(
      'countdown tick decrements resendCountdown',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 3,
      ),
      act: (bloc) => bloc.add(const OtpCountdownTicked()),
      expect: () => [
        isA<OtpState>().having(
          (s) => s.resendCountdown,
          'resendCountdown',
          2,
        ),
      ],
    );

    // ──── 10. Countdown stops at 0 ────
    blocTest<OtpBloc, OtpState>(
      'countdown stops at 0 and emits nothing',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: '',
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpCountdownTicked()),
      expect: () => <OtpState>[],
    );

    // ──── 11. Presentation on invalid OTP ────
    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpFailurePresentationEvent when invalid OTP is submitted',
      build: buildBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otp: invalidOtp,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpSubmitted()),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>().having(
          (e) => e.message,
          'message',
          'Invalid OTP provided',
        ),
      ],
    );

    // ──── 12. Presentation on resend failure ────
    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpFailurePresentationEvent when resend fails',
      build: buildUninitializedBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpResendRequested()),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>().having(
          (e) => e.message,
          'message',
          'Repository not initialized',
        ),
      ],
    );

    // ──── 13. Presentation on WhatsApp resend failure ────
    blocPresentationTest<OtpBloc, OtpState, OtpPresentationEvent>(
      'emits OtpFailurePresentationEvent when resend via WhatsApp fails',
      build: buildUninitializedBloc,
      seed: () => const OtpState(
        phoneNumber: testPhone,
        otpLength: 6,
        resendCountdown: 0,
      ),
      act: (bloc) => bloc.add(const OtpResendViaWhatsappRequested()),
      expectPresentation: () => [
        isA<OtpFailurePresentationEvent>().having(
          (e) => e.message,
          'message',
          'Repository not initialized',
        ),
      ],
    );
  });
}
