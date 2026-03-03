import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:parent_core/parent_core.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'otp_event.dart';
part 'otp_state.dart';

sealed class OtpPresentationEvent {
  const OtpPresentationEvent();
}

final class OtpFailurePresentationEvent extends OtpPresentationEvent {
  final MentorXException exception;
  const OtpFailurePresentationEvent({required this.exception});
}

final class OtpSuccessPresentationEvent extends OtpPresentationEvent {
  const OtpSuccessPresentationEvent();
}

final class OtpBloc extends Bloc<OtpEvent, OtpState>
    with BlocPresentationMixin<OtpState, OtpPresentationEvent> {
  final AuthenticationRepository _authenticationRepository;
  final MentorXLogger _logger = MentorXLogger('ParentOtpBloc');

  OtpBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(OtpInitial()) {
    on<OtpSubmittedEvent>(_onOtpSubmitted);
  }

  Future<void> _onOtpSubmitted(
    OtpSubmittedEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(OtpLoading());
    try {
      await _authenticationRepository.verifyOtp(event.phone, event.code);
      emit(OtpSuccess());
      emitPresentation(const OtpSuccessPresentationEvent());
    } on AuthenticationException catch (e) {
      _logger.error("OTP Verification failed: ${e.message}");
      emit(OtpFailure(exception: e));
      emitPresentation(OtpFailurePresentationEvent(exception: e));
    } catch (e) {
      _logger.error("Unexpected OTP error: $e");
      const exception =
          AuthenticationException(code: AuthenticationExceptionCode.unknown);
      emit(OtpFailure(exception: exception));
      emitPresentation(const OtpFailurePresentationEvent(exception: exception));
    }
  }
}
