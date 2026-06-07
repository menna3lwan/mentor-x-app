import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

sealed class ForgotPasswordPresentationEvent {}

final class ForgotPasswordSuccessPresentationEvent
    extends ForgotPasswordPresentationEvent {
  final String phone;

  ForgotPasswordSuccessPresentationEvent(this.phone);
}

final class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState>
    with
        BlocPresentationMixin<
          ForgotPasswordState,
          ForgotPasswordPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('ForgotPasswordBloc');

  final StudentAuthenticationRepository _authRepository;
  final AnalyticsService _analyticsService;

  ForgotPasswordBloc({
    required StudentAuthenticationRepository authRepository,
    required AnalyticsService analyticsService,
    String? initialPhone,
  }) : _authRepository = authRepository,
       _analyticsService = analyticsService,
       super(ForgotPasswordState(phone: initialPhone ?? '')) {
    on<ForgotPasswordPhoneChanged>(_onPhoneChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);

    _analyticsService.logEvent(name: AnalyticsEvents.forgotPasswordViewed);
  }

  void _onPhoneChanged(
    ForgotPasswordPhoneChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    _logger.info('_onPhoneChanged entered');
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    _logger.info('_onSubmitted entered');
    if (state.phone.isEmpty) return;

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _authRepository.requestPasswordReset(state.phone.trim());

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        ForgotPasswordSuccessPresentationEvent(state.phone.trim()),
      );
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
