import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent/core/core.dart';
import 'dart:async';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

sealed class ForgetPasswordPresentationEvent {
  const ForgetPasswordPresentationEvent();
}

final class ForgetPasswordSuccessPresentationEvent
    extends ForgetPasswordPresentationEvent {
  final String phone;
  const ForgetPasswordSuccessPresentationEvent({required this.phone});
}

final class ForgetPasswordFailurePresentationEvent
    extends ForgetPasswordPresentationEvent {
  final MentorXException exception;
  const ForgetPasswordFailurePresentationEvent({required this.exception});
}

final class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState>
    with
        BlocPresentationMixin<
          ForgetPasswordState,
          ForgetPasswordPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('ForgetPasswordBloc');

  ForgetPasswordBloc({
    required AuthenticationRepository authenticationRepository,
    required AnalyticsService analyticsService,
  }) : _authenticationRepository = authenticationRepository,
       _analyticsService = analyticsService,
       super(ForgetPasswordState.initial) {
    on<ForgetPasswordSubmittedEvent>(_onForgetPasswordSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;
  final AnalyticsService _analyticsService;

  Future<void> _onForgetPasswordSubmitted(
    ForgetPasswordSubmittedEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    _logger.info('Password reset request started for: ${event.phoneNumber}');
    emit(state.copyWith(loadingState: ForgetPasswordLoadingState.loading));
    try {
      await _authenticationRepository.requestPasswordReset(event.phoneNumber);
      unawaited(_analyticsService.logEvent(name: 'forget_password_requested'));
      _logger.info('Password reset request succeeded for: ${event.phoneNumber}');
      emit(state.copyWith(loadingState: ForgetPasswordLoadingState.success));
      emitPresentation(
        ForgetPasswordSuccessPresentationEvent(phone: event.phoneNumber),
      );
    } on AuthenticationException catch (e, s) {
      _logger.error('Authentication error requesting password reset for: ${event.phoneNumber}', e, s);
      emit(
        state.copyWith(
          loadingState: ForgetPasswordLoadingState.failure,
          exception: e,
        ),
      );
      emitPresentation(ForgetPasswordFailurePresentationEvent(exception: e));
    } catch (e, s) {
      _logger.error('Unexpected error requesting password reset for: ${event.phoneNumber}', e, s);
      final exception = AuthenticationException(
        code: AuthenticationExceptionCode.unknown,
        message: e.toString(),
      );
      emit(
        state.copyWith(
          loadingState: ForgetPasswordLoadingState.failure,
          exception: exception,
        ),
      );
      emitPresentation(ForgetPasswordFailurePresentationEvent(exception: exception));
    }
  }
}
