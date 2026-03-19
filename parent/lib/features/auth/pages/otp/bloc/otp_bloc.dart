import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent_core/parent_core.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'otp_event.dart';
part 'otp_state.dart';

// ──── Presentation events (one-time side effects) ────
sealed class OtpPresentationEvent {
  const OtpPresentationEvent();
}

final class OtpSuccessPresentationEvent extends OtpPresentationEvent {
  final ParentEntity user;
  const OtpSuccessPresentationEvent({required this.user});
}

final class OtpFailurePresentationEvent extends OtpPresentationEvent {
  final MentorXException exception;
  const OtpFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class OtpBloc extends Bloc<OtpEvent, OtpState>
    with BlocPresentationMixin<OtpState, OtpPresentationEvent> {
  final AuthenticationRepository _authenticationRepository;
  final MentorXLogger _logger = MentorXLogger('OtpBloc');

  OtpBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(OtpState.initial) {
    on<OtpSubmittedEvent>(_onOtpSubmitted);
  }

  Future<void> _onOtpSubmitted(
    OtpSubmittedEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(loadingState: OtpLoadingState.loading));
    try {
      final user =
          await _authenticationRepository.verifyOtp(event.phone, event.code);
      emit(state.copyWith(loadingState: OtpLoadingState.success));
      emitPresentation(OtpSuccessPresentationEvent(user: user));
    } on AuthenticationException catch (e) {
      _logger.error('OTP verification failed: ${e.message}');
      emit(state.copyWith(
        loadingState: OtpLoadingState.failure,
        exception: e,
      ));
      emitPresentation(OtpFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error('Unexpected OTP error: $e');
      const exception =
          AuthenticationException(code: AuthenticationExceptionCode.unknown);
      emit(state.copyWith(
        loadingState: OtpLoadingState.failure,
        exception: exception,
      ));
      emitPresentation(const OtpFailurePresentationEvent(exception: exception));
    }
  }
}
