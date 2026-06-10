import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'otp_event.dart';
part 'otp_state.dart';

// ──── Presentation events (one-time side effects) ────
sealed class OtpPresentationEvent {
  const OtpPresentationEvent();
}

final class OtpSuccessPresentationEvent extends OtpPresentationEvent {
  final ParentEntity user;
  const OtpSuccessPresentationEvent({required this.user});
}

final class OtpFailurePresentationEvent extends OtpPresentationEvent {
  final MentorXException exception;
  const OtpFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class OtpBloc extends Bloc<OtpEvent, OtpState>
    with BlocPresentationMixin<OtpState, OtpPresentationEvent> {
  final AuthenticationRepository _authenticationRepository;
  final MentorXLogger _logger = MentorXLogger('OtpBloc');
  Timer? _countdownTimer;

  OtpBloc({
    required AuthenticationRepository authenticationRepository,
    int initialResendCountdown = 60,
  }) : _authenticationRepository = authenticationRepository,
       super(
         OtpState(
           resendCountdown: initialResendCountdown,
           loadingState: OtpLoadingState.initial,
         ),
       ) {
    on<OtpSubmittedEvent>(_onOtpSubmitted, transformer: droppable());
    on<OtpResendRequested>(_onResendRequested, transformer: droppable());
    on<OtpCountdownTicked>(_onCountdownTicked);

    _startCountdown();
  }

  Future<void> _onOtpSubmitted(
    OtpSubmittedEvent event,
    Emitter<OtpState> emit,
  ) async {
    _logger.info(
      '🔵 [OTP_BLOC] _onOtpSubmitted START: phone=${event.phone}, code=${event.code}',
    );
    emit(state.copyWith(loadingState: OtpLoadingState.loading));
    try {
      _logger.info('🔵 [OTP_BLOC] Calling verifyOtp on repository...');
      final user = await _authenticationRepository.verifyOtp(
        event.phone,
        event.code,
      );
      _logger.info(
        '🟢 [OTP_BLOC] OTP Verification SUCCESS: user=${user.fullName}, id=${user.id}, status=${user.status.name}',
      );
      emit(state.copyWith(loadingState: OtpLoadingState.success));
      _logger.info('🟢 [OTP_BLOC] Emitting OtpSuccessPresentationEvent...');
      emitPresentation(OtpSuccessPresentationEvent(user: user));
    } on AuthenticationException catch (e) {
      _logger.error(
        '🔴 [OTP_BLOC] OTP Verification FAILED: code=${e.code}, message=${e.message}',
      );
      emit(
        state.copyWith(
          loadingState: OtpLoadingState.failure,
          exception: e,
        ),
      );
      emitPresentation(OtpFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error('🔴 [OTP_BLOC] Unexpected OTP error: $e');
      const exception = AuthenticationException(
        code: AuthenticationExceptionCode.unknown,
      );
      emit(
        state.copyWith(
          loadingState: OtpLoadingState.failure,
          exception: exception,
        ),
      );
      emitPresentation(const OtpFailurePresentationEvent(exception: exception));
    }
  }

  Future<void> _onResendRequested(
    OtpResendRequested event,
    Emitter<OtpState> emit,
  ) async {
    if (!state.canResend) {
      return;
    }

    emit(state.copyWith(isResending: true));

    try {
      final duration = await _authenticationRepository.resendOtp(event.phone);
      emit(
        state.copyWith(
          isResending: false,
          resendCountdown: duration?.inSeconds ?? 60,
        ),
      );
      _startCountdown();
    } on AuthenticationException catch (e) {
      emit(state.copyWith(isResending: false));
      emitPresentation(OtpFailurePresentationEvent(exception: e));
    } catch (e, s) {
      _logger.error('Unexpected resend OTP error: $e', e, s);
      const exception = AuthenticationException(
        code: AuthenticationExceptionCode.unknown,
      );
      emit(state.copyWith(isResending: false, exception: exception));
      emitPresentation(const OtpFailurePresentationEvent(exception: exception));
    }
  }

  void _onCountdownTicked(
    OtpCountdownTicked event,
    Emitter<OtpState> emit,
  ) {
    if (state.resendCountdown <= 0) {
      _countdownTimer?.cancel();
      return;
    }

    emit(state.copyWith(resendCountdown: state.resendCountdown - 1));
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    if (state.resendCountdown <= 0) {
      return;
    }

    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const OtpCountdownTicked()),
    );
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
