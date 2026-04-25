import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

sealed class ResetPasswordPresentationEvent {}

final class ResetPasswordSuccessPresentationEvent extends ResetPasswordPresentationEvent {}

final class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>
    with BlocPresentationMixin<ResetPasswordState, ResetPasswordPresentationEvent> {
  final StudentAuthenticationRepository _authRepository;

  ResetPasswordBloc({
    required StudentAuthenticationRepository authRepository,
    required String phoneNumber,
  })  : _authRepository = authRepository,
        super(ResetPasswordState(phoneNumber: phoneNumber)) {
    on<ResetPasswordOtpChanged>(_onOtpChanged);
    on<ResetPasswordNewPasswordChanged>(_onNewPasswordChanged);
    on<ResetPasswordConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  void _onOtpChanged(ResetPasswordOtpChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  void _onNewPasswordChanged(ResetPasswordNewPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(newPassword: event.password));
  }

  void _onConfirmPasswordChanged(ResetPasswordConfirmPasswordChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(confirmPassword: event.password));
  }

  Future<void> _onSubmitted(ResetPasswordSubmitted event, Emitter<ResetPasswordState> emit) async {
    if (state.otp.length != 6 || state.newPassword.isEmpty || state.newPassword != state.confirmPassword) {
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _authRepository.resetPassword(
        phoneNumber: state.phoneNumber,
        otp: state.otp.trim(),
        newPassword: state.newPassword,
      );

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(ResetPasswordSuccessPresentationEvent());
    } on AuthenticationRepositoryException catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: MentorXNullableValue(e.message ?? 'An error occurred'),
      ));
    } catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: const MentorXNullableValue('An unexpected error occurred'),
      ));
    }
  }
}
