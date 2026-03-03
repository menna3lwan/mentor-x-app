import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

sealed class ForgetPasswordPresentationEvent {
  const ForgetPasswordPresentationEvent();
}

final class ForgetPasswordFailurePresentationEvent
    extends ForgetPasswordPresentationEvent {
  final MentorXException exception;
  const ForgetPasswordFailurePresentationEvent({required this.exception});
}

final class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState>
    with
        BlocPresentationMixin<ForgetPasswordState,
            ForgetPasswordPresentationEvent> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>((event, emit) {
      // Handle events
    });
  }
}
