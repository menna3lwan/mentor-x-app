import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

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
  ForgetPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
       super(ForgetPasswordState.initial) {
    on<ForgetPasswordSubmittedEvent>(
      _onForgetPasswordSubmitted,
      transformer: droppable(),
    );
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onForgetPasswordSubmitted(
    ForgetPasswordSubmittedEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(state.copyWith(loadingState: ForgetPasswordLoadingState.loading));
    try {
      await _authenticationRepository.requestPasswordReset(event.phoneNumber);
      emit(state.copyWith(loadingState: ForgetPasswordLoadingState.success));
      emitPresentation(
        ForgetPasswordSuccessPresentationEvent(phone: event.phoneNumber),
      );
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(
          loadingState: ForgetPasswordLoadingState.failure,
          exception: e,
        ),
      );
      emitPresentation(ForgetPasswordFailurePresentationEvent(exception: e));
    } catch (e) {
      // Network failure, parser bugs, anything else — surface as a generic
      // failure instead of letting the bloc crash silently.
      const exception = AuthenticationException(
        code: AuthenticationExceptionCode.unknown,
      );
      emit(
        state.copyWith(
          loadingState: ForgetPasswordLoadingState.failure,
          exception: exception,
        ),
      );
      emitPresentation(
        const ForgetPasswordFailurePresentationEvent(exception: exception),
      );
    }
  }
}
