import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'status_rejected_page_event.dart';
part 'status_rejected_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusRejectedPagePresentationEvent {
  const StatusRejectedPagePresentationEvent();
}

final class StatusRejectedPageFailurePresentationEvent
    extends StatusRejectedPagePresentationEvent {
  final MentorXException exception;
  const StatusRejectedPageFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StatusRejectedPageBloc
    extends Bloc<StatusRejectedPageEvent, StatusRejectedPageState>
    with
        BlocPresentationMixin<
          StatusRejectedPageState,
          StatusRejectedPagePresentationEvent
        > {
  StatusRejectedPageBloc({required this.analyticsService})
    : super(StatusRejectedPageState.initial) {
    on<StatusRejectedPageInitialized>(_onInitialized);
  }

  final AnalyticsService analyticsService;

  void _onInitialized(
    StatusRejectedPageInitialized event,
    Emitter<StatusRejectedPageState> emit,
  ) {
    analyticsService.logEvent(
      name: AnalyticsEvents.accountStatusViewed,
      parameters: {AnalyticsParams.status: 'rejected'},
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
