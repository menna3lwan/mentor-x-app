import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/core.dart';

part 'status_blocked_page_event.dart';
part 'status_blocked_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusBlockedPagePresentationEvent {
  const StatusBlockedPagePresentationEvent();
}

final class StatusBlockedPageFailurePresentationEvent
    extends StatusBlockedPagePresentationEvent {
  final MentorXException exception;
  const StatusBlockedPageFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StatusBlockedPageBloc
    extends Bloc<StatusBlockedPageEvent, StatusBlockedPageState>
    with
        BlocPresentationMixin<
          StatusBlockedPageState,
          StatusBlockedPagePresentationEvent
        > {
  StatusBlockedPageBloc() : super(StatusBlockedPageState.initial) {
    on<StatusBlockedPageInitialized>(_onInitialized);
  }

  void _onInitialized(
    StatusBlockedPageInitialized event,
    Emitter<StatusBlockedPageState> emit,
  ) {
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
