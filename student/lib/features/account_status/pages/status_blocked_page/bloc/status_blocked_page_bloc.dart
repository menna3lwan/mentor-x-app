import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
  StatusBlockedPageBloc({required this.analyticsService})
    : super(StatusBlockedPageState.initial) {
    on<StatusBlockedPageInitialized>(_onInitialized);
  }

  final AnalyticsService analyticsService;

  void _onInitialized(
    StatusBlockedPageInitialized event,
    Emitter<StatusBlockedPageState> emit,
  ) {
    analyticsService.logEvent(
      name: AnalyticsEvents.accountStatusViewed,
      parameters: {AnalyticsParams.status: 'blocked'},
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
