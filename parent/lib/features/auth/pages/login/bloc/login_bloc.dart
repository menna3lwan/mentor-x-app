import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

final class LoginOtpRequiredPresentationEvent extends LoginPresentationEvent {
  final String phoneNumber;
  const LoginOtpRequiredPresentationEvent({required this.phoneNumber});
}

// ──── Bloc ────
final class LoginBloc extends Bloc<LoginEvent, LoginState>
    with BlocPresentationMixin<LoginState, LoginPresentationEvent> {
  final AuthenticationRepository<ParentEntity> _authenticationRepository;
  final DeviceInfoService _deviceInfoService;
  final MentorXLogger _logger = MentorXLogger('LoginBloc');

  LoginBloc({
    required AuthenticationRepository<ParentEntity> authenticationRepository,
    required DeviceInfoService deviceInfoService,
  }) : _authenticationRepository = authenticationRepository,
       _deviceInfoService = deviceInfoService,
       super(LoginState.initial) {
    // Drop rapid duplicate submits — only one login request runs at a time.
    on<LoginSubmittedEvent>(_onLoginSubmitted, transformer: droppable());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    _logger.info(
      '🔵 [LOGIN_BLOC] Login submitted: phone=${event.phoneNumber}, fcmToken=${event.fcmToken != null}',
    );
    emit(state.copyWith(loadingState: LoginLoadingState.loading));
    try {
      final deviceName = await _deviceInfoService.getDeviceName();
      final deviceHash = await _deviceInfoService.getDeviceHash();
      final appVersion = await _deviceInfoService.getAppVersion();

      _logger.info(
        '🔵 [LOGIN_BLOC] Calling repository.login with deviceName=$deviceName deviceHash=$deviceHash appVersion=$appVersion',
      );

      final user = await _authenticationRepository.login(
        phone: event.phoneNumber,
        password: event.password,
        deviceHash: deviceHash,
        deviceName: deviceName,
        fcmToken: event.fcmToken,
        appVersion: appVersion,
      );
      _logger.info(
        '🟢 [LOGIN_BLOC] Repository login completed successfully for user=${user.fullName}, id=${user.id}, status=${user.status.name}',
      );
      emit(state.copyWith(loadingState: LoginLoadingState.success));
      emitPresentation(LoginSuccessPresentationEvent(user: user));
    } on AuthenticationException catch (e) {
      if (e.code == AuthenticationExceptionCode.otpRequired) {
        _logger.info(
          '🟡 [LOGIN_BLOC] OTP required — transitioning to OTP screen',
        );
        emit(state.copyWith(loadingState: LoginLoadingState.initial));
        emitPresentation(
          LoginOtpRequiredPresentationEvent(phoneNumber: event.phoneNumber),
        );
        return;
      }

      _logger.error('Login failed: ${e.message}');
      emit(
        state.copyWith(
          loadingState: LoginLoadingState.failure,
          exception: e,
        ),
      );
      emitPresentation(LoginFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error('Unexpected login error: $e');
      const exception = AuthenticationException(
        code: AuthenticationExceptionCode.unknown,
      );
      emit(
        state.copyWith(
          loadingState: LoginLoadingState.failure,
          exception: exception,
        ),
      );
      emitPresentation(
        const LoginFailurePresentationEvent(exception: exception),
      );
    }
  }
}
