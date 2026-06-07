import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

sealed class ResetPasswordPresentationEvent {}

final class ResetPasswordSuccessPresentationEvent
    extends ResetPasswordPresentationEvent {}

final class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordState>
    with
        BlocPresentationMixin<
          ResetPasswordState,
          ResetPasswordPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('ResetPasswordBloc');

  final StudentAuthenticationRepository _authRepository;
  final AnalyticsService _analyticsService;

  ResetPasswordBloc({
    required StudentAuthenticationRepository authRepository,
    required AnalyticsService analyticsService,
    required String phoneNumber,
  }) : _authRepository = authRepository,
       _analyticsService = analyticsService,
       super(ResetPasswordState(phoneNumber: phoneNumber)) {
    on<ResetPasswordOtpChanged>(_onOtpChanged);
    on<ResetPasswordNewPasswordChanged>(_onNewPasswordChanged);
    on<ResetPasswordConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);

    _analyticsService.logEvent(name: AnalyticsEvents.resetPasswordViewed);
  }

  void _onOtpChanged(
    ResetPasswordOtpChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    _logger.info('_onOtpChanged entered');
    emit(state.copyWith(otp: event.otp));
  }

  void _onNewPasswordChanged(
    ResetPasswordNewPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    _logger.info('_onNewPasswordChanged entered');
    emit(state.copyWith(newPassword: event.password));
  }

  void _onConfirmPasswordChanged(
    ResetPasswordConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    _logger.info('_onConfirmPasswordChanged entered');
    emit(state.copyWith(confirmPassword: event.password));
  }

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    _logger.info('_onSubmitted entered');
    if (state.otp.length != 6 ||
        state.newPassword.isEmpty ||
        state.newPassword != state.confirmPassword) {
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      // Step 1: Verify OTP to acquire authorization token
      await _authRepository.verifyOtp(state.otp.trim());

      // Step 2: Reset password using the acquired token
      await _authRepository.resetPassword(
        phoneNumber: state.phoneNumber,
        newPassword: state.newPassword,
      );

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(ResetPasswordSuccessPresentationEvent());
    } on AuthenticationRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message ?? 'An error occurred'),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: const MentorXNullableValue(
            'An unexpected error occurred',
          ),
        ),
      );
    }
  }
}
