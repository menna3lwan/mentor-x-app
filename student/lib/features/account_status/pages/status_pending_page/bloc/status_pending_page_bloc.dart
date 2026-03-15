import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/core.dart';

part 'status_pending_page_event.dart';
part 'status_pending_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusPendingPagePresentationEvent {
  const StatusPendingPagePresentationEvent();
}

final class StatusPendingPageFailurePresentationEvent
    extends StatusPendingPagePresentationEvent {
  final MentorXException exception;
  const StatusPendingPageFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StatusPendingPageBloc
    extends Bloc<StatusPendingPageEvent, StatusPendingPageState>
    with
        BlocPresentationMixin<
          StatusPendingPageState,
          StatusPendingPagePresentationEvent
        > {
  StatusPendingPageBloc() : super(StatusPendingPageState.initial) {
    on<StatusPendingPageInitialized>(_onInitialized);
  }

  void _onInitialized(
    StatusPendingPageInitialized event,
    Emitter<StatusPendingPageState> emit,
  ) {
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
