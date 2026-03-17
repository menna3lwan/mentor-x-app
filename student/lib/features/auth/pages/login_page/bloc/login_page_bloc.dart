import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class LoginPagePresentationEvent {
  const LoginPagePresentationEvent();
}

final class LoginPageNavigateToOtpPresentationEvent
    extends LoginPagePresentationEvent {
  final String phoneNumber;
  final int? otpLength;
  final Duration? otpDuration;

  const LoginPageNavigateToOtpPresentationEvent({
    required this.phoneNumber,
    this.otpLength,
    this.otpDuration,
  });
}

final class LoginPageFailurePresentationEvent
    extends LoginPagePresentationEvent {
  final String message;
  const LoginPageFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState>
    with BlocPresentationMixin<LoginPageState, LoginPagePresentationEvent> {
  final StudentAuthenticationRepository _authRepository;

  LoginPageBloc({
    required StudentAuthenticationRepository authRepository,
  }) : _authRepository = authRepository,
       super(LoginPageState.initial) {
    on<LoginPagePhoneChanged>(_onPhoneChanged);
    on<LoginPageSubmitted>(_onSubmitted);
  }

  void _onPhoneChanged(
    LoginPagePhoneChanged event,
    Emitter<LoginPageState> emit,
  ) {
    emit(
      state.copyWith(
        phoneNumber: event.phoneNumber,
        loadingState: LoadingState.initial,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginPageSubmitted event,
    Emitter<LoginPageState> emit,
  ) async {
    if (state.phoneNumber.trim().isEmpty) return;

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final result = await _authRepository.sendOtp(state.phoneNumber.trim());
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        LoginPageNavigateToOtpPresentationEvent(
          phoneNumber: state.phoneNumber.trim(),
          otpLength: result?.otpLength,
          otpDuration: result?.otpDuration,
        ),
      );
    } on AuthenticationRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        LoginPageFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        LoginPageFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
