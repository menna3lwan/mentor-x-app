import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'status_blocked_event.dart';
part 'status_blocked_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusBlockedPresentationEvent {
  const StatusBlockedPresentationEvent();
}

final class StatusBlockedFailurePresentationEvent
    extends StatusBlockedPresentationEvent {
  final MentorXException exception;
  const StatusBlockedFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StatusBlockedBloc
    extends Bloc<StatusBlockedEvent, StatusBlockedState>
    with
        BlocPresentationMixin<
          StatusBlockedState,
          StatusBlockedPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('StatusBlockedBloc');

  StatusBlockedBloc({required this.analyticsService})
    : super(StatusBlockedState.initial) {
    on<StatusBlockedInitialized>(_onInitialized);
  }

  final AnalyticsService analyticsService;

  void _onInitialized(
    StatusBlockedInitialized event,
    Emitter<StatusBlockedState> emit,
  ) {
    _logger.info('Initializing StatusBlockedBloc');
    analyticsService.logEvent(
      name: AnalyticsEvents.accountStatusViewed,
      parameters: {AnalyticsParams.status: 'blocked'},
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
