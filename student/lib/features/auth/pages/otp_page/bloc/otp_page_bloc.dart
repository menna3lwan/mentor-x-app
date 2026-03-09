import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'otp_page_event.dart';
part 'otp_page_state.dart';

final class OtpPageBloc extends Bloc<OtpPageEvent, OtpPageState> {
  final StudentAuthenticationRepository _authRepository;

  OtpPageBloc({
    required StudentAuthenticationRepository authRepository,
    required String phoneNumber,
    int? otpLength,
    Duration? otpDuration,
  })  : _authRepository = authRepository,
        super(OtpPageState(
          phoneNumber: phoneNumber,
          otpLength: otpLength ?? 6,
          resendCountdown: otpDuration?.inSeconds ?? 60,
        )) {
    on<OtpPageOtpChanged>(_onOtpChanged);
    on<OtpPageSubmitted>(_onSubmitted);
    on<OtpPageResendRequested>(_onResendRequested);
    on<OtpPageCountdownTicked>(_onCountdownTicked);

    _startCountdown();
  }

  Timer? _countdownTimer;

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const OtpPageCountdownTicked()),
    );
  }

  void _onOtpChanged(
    OtpPageOtpChanged event,
    Emitter<OtpPageState> emit,
  ) {
    emit(state.copyWith(
      otp: event.otp,
      status: OtpPageStatus.initial,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitted(
    OtpPageSubmitted event,
    Emitter<OtpPageState> emit,
  ) async {
    if (state.otp.length != state.otpLength) return;

    emit(state.copyWith(status: OtpPageStatus.loading));

    try {
      final user = await _authRepository.verifyOtp(state.otp);
      emit(state.copyWith(
        status: OtpPageStatus.success,
        user: user,
      ));
    } on AuthenticationRepositoryException catch (e) {
      emit(state.copyWith(
        status: OtpPageStatus.failure,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OtpPageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onResendRequested(
    OtpPageResendRequested event,
    Emitter<OtpPageState> emit,
  ) async {
    if (state.resendCountdown > 0) return;

    emit(state.copyWith(isResending: true));

    try {
      final duration = await _authRepository.resendOtp(state.phoneNumber);
      emit(state.copyWith(
        isResending: false,
        resendCountdown: duration?.inSeconds ?? 60,
      ));
      _startCountdown();
    } catch (e) {
      emit(state.copyWith(isResending: false));
    }
  }

  void _onCountdownTicked(
    OtpPageCountdownTicked event,
    Emitter<OtpPageState> emit,
  ) {
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
