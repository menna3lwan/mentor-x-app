import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

sealed class ForgotPasswordPresentationEvent {}

final class ForgotPasswordSuccessPresentationEvent extends ForgotPasswordPresentationEvent {
  final String phone;

  ForgotPasswordSuccessPresentationEvent(this.phone);
}

final class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState>
    with BlocPresentationMixin<ForgotPasswordState, ForgotPasswordPresentationEvent> {
  final StudentAuthenticationRepository _authRepository;

  ForgotPasswordBloc({
    required StudentAuthenticationRepository authRepository,
    String? initialPhone,
  })  : _authRepository = authRepository,
        super(ForgotPasswordState(phone: initialPhone ?? '')) {
    on<ForgotPasswordPhoneChanged>(_onPhoneChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onPhoneChanged(
    ForgotPasswordPhoneChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.phone.isEmpty) return;

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _authRepository.requestPasswordReset(state.phone.trim());
      
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(ForgotPasswordSuccessPresentationEvent(state.phone.trim()));
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
