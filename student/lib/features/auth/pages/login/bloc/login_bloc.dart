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

final class LoginDeviceLimitReachedPresentationEvent
    extends LoginPresentationEvent {
  final String message;
  final int maxDevices;
  final List<DeviceEntity> activeDevices;

  const LoginDeviceLimitReachedPresentationEvent({
    required this.message,
    required this.maxDevices,
    required this.activeDevices,
  });
}

final class LoginFailurePresentationEvent extends LoginPresentationEvent {
  final String message;
  const LoginFailurePresentationEvent({required this.message});
}

// ──── Bloc ────
final class LoginBloc extends Bloc<LoginEvent, LoginState>
    with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  static const int _maxFailedAttempts = 5;
  static const Duration _lockoutDuration = Duration(minutes: 15);

  final StudentAuthenticationRepository _authRepository;
  int _failedAttempts = 0;
  DateTime? _lockedUntil;
  String? _attemptPhoneNumber;

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
    final phoneNumber = state.phoneNumber.trim();
    if (phoneNumber.isEmpty || state.password.trim().isEmpty) {
      return;
    }

    _syncAttemptPhone(phoneNumber);

    if (_isCurrentlyLockedOut) {
      final message = _buildLockoutMessage();
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: message,
        ),
      );
      emitPresentation(LoginFailurePresentationEvent(message: message));
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final user = await _authRepository.loginWithPassword(
        phoneNumber: phoneNumber,
        password: state.password.trim(),
      );
      _resetFailedAttempts();
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        LoginSuccessPresentationEvent(user: user),
      );
    } on AuthenticationRequiresOtpException catch (e) {
      emit(state.copyWith(loadingState: LoadingState.initial));
      emitPresentation(
        LoginNavigateToOtpPresentationEvent(
          phoneNumber: state.phoneNumber.trim(),
          otpDuration: e.otpDuration,
          otpLength: e.otpLength,
        ),
      );
    } on DeviceLimitReachedException catch (e) {
      final fallbackMessage =
          'Maximum number of devices reached. Please deactivate an existing device and try again.';
      final message = e.message?.trim().isNotEmpty == true
          ? e.message!
          : fallbackMessage;

      _registerFailedAttempt();
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: message,
        ),
      );
      emitPresentation(
        LoginDeviceLimitReachedPresentationEvent(
          message: message,
          maxDevices: e.maxDevices,
          activeDevices: e.activeDevices,
        ),
      );
    } on AuthenticationRepositoryException catch (e) {
      final fallbackMessage =
          e.message?.trim().isNotEmpty == true ? e.message! : 'Login failed.';
      final message = _registerFailedAttempt(fallbackMessage: fallbackMessage);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: message,
        ),
      );
      emitPresentation(LoginFailurePresentationEvent(message: message));
    } catch (e) {
      final message = _registerFailedAttempt(fallbackMessage: e.toString());
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: message,
        ),
      );
      emitPresentation(LoginFailurePresentationEvent(message: message));
    }
  }

  void _syncAttemptPhone(String phoneNumber) {
    if (_attemptPhoneNumber == phoneNumber) {
      return;
    }

    _attemptPhoneNumber = phoneNumber;
    _resetFailedAttempts();
  }

  bool get _isCurrentlyLockedOut {
    if (_lockedUntil == null) {
      return false;
    }
    return DateTime.now().isBefore(_lockedUntil!);
  }

  void _resetFailedAttempts() {
    _failedAttempts = 0;
    _lockedUntil = null;
  }

  String _registerFailedAttempt({String? fallbackMessage}) {
    _failedAttempts += 1;

    if (_failedAttempts >= _maxFailedAttempts) {
      _lockedUntil = DateTime.now().add(_lockoutDuration);
      return _buildLockoutMessage();
    }

    final attemptsLeft = _maxFailedAttempts - _failedAttempts;
    final baseMessage = (fallbackMessage ?? 'Login failed.').trim();
    return '$baseMessage Attempts left: $attemptsLeft.';
  }

  String _buildLockoutMessage() {
    final lockedUntil = _lockedUntil;
    if (lockedUntil == null) {
      return 'Too many failed attempts. Please try again later.';
    }

    final remaining = lockedUntil.difference(DateTime.now());
    final minutes = remaining.inMinutes <= 0 ? 1 : remaining.inMinutes;
    return 'Account temporarily locked. Try again in $minutes minute(s).';
  }
}
