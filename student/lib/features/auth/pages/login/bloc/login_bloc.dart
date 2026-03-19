import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'login_event.dart';
part 'login_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class LoginPresentationEvent {
  const LoginPresentationEvent();
}

final class LoginSuccessPresentationEvent extends LoginPresentationEvent {
  final StudentEntity user;
  const LoginSuccessPresentationEvent({required this.user});
}

final class LoginNavigateToOtpPresentationEvent extends LoginPresentationEvent {
  final String phoneNumber;
  final int? otpLength;
  final Duration? otpDuration;

  const LoginNavigateToOtpPresentationEvent({
    required this.phoneNumber,
    this.otpLength,
    this.otpDuration,
  });
}

final class LoginFailurePresentationEvent extends LoginPresentationEvent {
  final String message;
  const LoginFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class LoginBloc extends Bloc<LoginEvent, LoginState>
    with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  final StudentAuthenticationRepository _authRepository;

  LoginBloc({
    required StudentAuthenticationRepository authRepository,
  }) : _authRepository = authRepository,
       super(LoginState.initial) {
    on<LoginPhoneChanged>(_onPhoneChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginObscurePasswordToggled>(_onObscurePasswordToggled);
    on<LoginRememberMeToggled>(_onRememberMeToggled);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onPhoneChanged(
    LoginPhoneChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        phoneNumber: event.phoneNumber,
        loadingState: LoadingState.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        loadingState: LoadingState.initial,
        errorMessage: null,
      ),
    );
  }

  void _onObscurePasswordToggled(
    LoginObscurePasswordToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onRememberMeToggled(
    LoginRememberMeToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.phoneNumber.trim().isEmpty || state.password.trim().isEmpty) {
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final user = await _authRepository.loginWithPassword(
        phoneNumber: state.phoneNumber.trim(),
        password: state.password.trim(),
      );
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        LoginSuccessPresentationEvent(user: user),
      );
    } on AuthenticationRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        LoginFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        LoginFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
