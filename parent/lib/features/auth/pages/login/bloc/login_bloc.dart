import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent_core/parent_core.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'login_event.dart';
part 'login_state.dart';

sealed class LoginPresentationEvent {
  const LoginPresentationEvent();
}

final class LoginFailurePresentationEvent extends LoginPresentationEvent {
  final MentorXException exception;
  const LoginFailurePresentationEvent({required this.exception});
}

final class LoginSuccessPresentationEvent extends LoginPresentationEvent {
  const LoginSuccessPresentationEvent();
}

final class LoginBloc extends Bloc<LoginEvent, LoginState>
    with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  final AuthenticationRepository _authenticationRepository;
  final MentorXLogger _logger = MentorXLogger('ParentLoginBloc');

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.login(
        phone: event.phoneNumber,
        password: event.password,
      );
      emit(LoginSuccess());
      emitPresentation(const LoginSuccessPresentationEvent());
    } on AuthenticationException catch (e) {
      _logger.error("Login failed: ${e.message}");
      emit(LoginFailure(exception: e));
      emitPresentation(LoginFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error("Unexpected login error: $e");
      const exception =
          AuthenticationException(code: AuthenticationExceptionCode.unknown);
      emit(LoginFailure(exception: exception));
      emitPresentation(
          const LoginFailurePresentationEvent(exception: exception));
    }
  }
}
