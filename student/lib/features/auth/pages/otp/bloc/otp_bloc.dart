import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'otp_event.dart';
part 'otp_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class OtpPresentationEvent {
  const OtpPresentationEvent();
}

final class OtpAuthenticatedPresentationEvent extends OtpPresentationEvent {
  final StudentEntity user;
  const OtpAuthenticatedPresentationEvent({required this.user});
}

final class OtpFailurePresentationEvent extends OtpPresentationEvent {
  final String message;
  const OtpFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class OtpBloc extends Bloc<OtpEvent, OtpState>
    with BlocPresentationMixin<OtpState, OtpPresentationEvent> {
  static final MentorXLogger _logger = MentorXLogger('OtpBloc');

  final StudentAuthenticationRepository _authRepository;
  final AnalyticsService _analyticsService;

  OtpBloc({
    required StudentAuthenticationRepository authRepository,
    required AnalyticsService analyticsService,
    required String phoneNumber,
    int? otpLength,
    Duration? otpDuration,
  }) : _authRepository = authRepository,
       _analyticsService = analyticsService,
       super(
         OtpState(
           phoneNumber: phoneNumber,
           otpLength: otpLength ?? 6,
           resendCountdown: otpDuration?.inSeconds ?? 60,
         ),
       ) {
    on<OtpOtpChanged>(_onOtpChanged);
    on<OtpSubmitted>(_onSubmitted);
    on<OtpResendRequested>(_onResendRequested);
    on<OtpResendViaWhatsappRequested>(_onResendViaWhatsappRequested);
    on<OtpCountdownTicked>(_onCountdownTicked);

    _analyticsService.logEvent(name: AnalyticsEvents.otpViewed);
    _startCountdown();
  }

  Timer? _countdownTimer;

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const OtpCountdownTicked()),
    );
  }

  void _onOtpChanged(
    OtpOtpChanged event,
    Emitter<OtpState> emit,
  ) {
    _logger.info('_onOtpChanged entered');
    emit(
      state.copyWith(
        otp: event.otp,
        loadingState: LoadingState.initial,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    _logger.info('_onSubmitted entered');
    if (state.otp.length != state.otpLength) return;

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final user = await _authRepository.verifyOtp(state.otp);
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        OtpAuthenticatedPresentationEvent(user: user),
      );
    } on AuthenticationRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        OtpFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        OtpFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onResendRequested(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    _logger.info('_onResendRequested entered');
    if (state.resendCountdown > 0) return;

    emit(state.copyWith(isResending: true));

    try {
      final duration = await _authRepository.resendOtp(state.phoneNumber);
      emit(
        state.copyWith(
          isResending: false,
          resendCountdown: duration?.inSeconds ?? 60,
        ),
      );
      _startCountdown();
    } on AuthenticationRepositoryException catch (e) {
      emit(state.copyWith(isResending: false));
      emitPresentation(
        OtpFailurePresentationEvent(
          message: e.message ?? 'Failed to resend OTP. Please try again.',
        ),
      );
    } catch (e) {
      emit(state.copyWith(isResending: false));
      emitPresentation(
        OtpFailurePresentationEvent(
          message: 'Failed to resend OTP. Please try again.',
        ),
      );
    }
  }

  Future<void> _onResendViaWhatsappRequested(
    OtpResendViaWhatsappRequested event,
    Emitter<OtpState> emit,
  ) async {
    _logger.info('_onResendViaWhatsappRequested entered');
    if (state.resendCountdown > 0) return;

    emit(state.copyWith(isResendingWhatsapp: true));

    try {
      final duration = await _authRepository.resendOtp(state.phoneNumber);
      emit(
        state.copyWith(
          isResendingWhatsapp: false,
          resendCountdown: duration?.inSeconds ?? 60,
        ),
      );
      _startCountdown();
    } on AuthenticationRepositoryException catch (e) {
      emit(state.copyWith(isResendingWhatsapp: false));
      emitPresentation(
        OtpFailurePresentationEvent(
          message:
              e.message ??
              'Failed to resend OTP via WhatsApp. Please try again.',
        ),
      );
    } catch (_) {
      emit(state.copyWith(isResendingWhatsapp: false));
      emitPresentation(
        const OtpFailurePresentationEvent(
          message: 'Failed to resend OTP via WhatsApp. Please try again.',
        ),
      );
    }
  }

  void _onCountdownTicked(
    OtpCountdownTicked event,
    Emitter<OtpState> emit,
  ) {
    _logger.info('_onCountdownTicked entered');
    if (state.resendCountdown <= 0) {
      _countdownTimer?.cancel();
      return;
    }
    emit(state.copyWith(resendCountdown: state.resendCountdown - 1));
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
