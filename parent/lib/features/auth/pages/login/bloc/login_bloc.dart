import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent_core/parent_core.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'login_event.dart';
part 'login_state.dart';

// ──── Presentation events (one-time side effects) ────
sealed class LoginPresentationEvent {
  const LoginPresentationEvent();
}

final class LoginSuccessPresentationEvent extends LoginPresentationEvent {
  final ParentEntity user;
  const LoginSuccessPresentationEvent({required this.user});
}

final class LoginFailurePresentationEvent extends LoginPresentationEvent {
  final MentorXException exception;
  const LoginFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class LoginBloc extends Bloc<LoginEvent, LoginState>
    with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  final AuthenticationRepository _authenticationRepository;
  final MentorXLogger _logger = MentorXLogger('LoginBloc');

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginState.initial) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoginLoadingState.loading));
    try {
      final user = await _authenticationRepository.login(
        phone: event.phoneNumber,
        password: event.password,
      );
      emit(state.copyWith(loadingState: LoginLoadingState.success));
      emitPresentation(LoginSuccessPresentationEvent(user: user));
    } on AuthenticationException catch (e) {
      _logger.error('Login failed: ${e.message}');
      emit(state.copyWith(
        loadingState: LoginLoadingState.failure,
        exception: e,
      ));
      emitPresentation(LoginFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error('Unexpected login error: $e');
      const exception =
          AuthenticationException(code: AuthenticationExceptionCode.unknown);
      emit(state.copyWith(
        loadingState: LoginLoadingState.failure,
        exception: exception,
      ));
      emitPresentation(
          const LoginFailurePresentationEvent(exception: exception));
    }
  }
}
