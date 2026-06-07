import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'status_rejected_event.dart';
part 'status_rejected_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusRejectedPresentationEvent {
  const StatusRejectedPresentationEvent();
}

final class StatusRejectedFailurePresentationEvent
    extends StatusRejectedPresentationEvent {
  final MentorXException exception;
  const StatusRejectedFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StatusRejectedBloc
    extends Bloc<StatusRejectedEvent, StatusRejectedState>
    with
        BlocPresentationMixin<
          StatusRejectedState,
          StatusRejectedPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('StatusRejectedBloc');

  StatusRejectedBloc({required this.analyticsService})
    : super(StatusRejectedState.initial) {
    on<StatusRejectedInitialized>(_onInitialized);
  }

  final AnalyticsService analyticsService;

  void _onInitialized(
    StatusRejectedInitialized event,
    Emitter<StatusRejectedState> emit,
  ) {
    _logger.info('Initializing StatusRejectedBloc');
    analyticsService.logEvent(
      name: AnalyticsEvents.accountStatusViewed,
      parameters: {AnalyticsParams.status: 'rejected'},
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
