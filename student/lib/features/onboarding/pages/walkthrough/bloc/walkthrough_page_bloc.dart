import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'walkthrough_page_event.dart';
part 'walkthrough_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class WalkthroughPagePresentationEvent {
  const WalkthroughPagePresentationEvent();
}

final class WalkthroughPageCompletedPresentationEvent
    extends WalkthroughPagePresentationEvent {
  const WalkthroughPageCompletedPresentationEvent();
}

final class WalkthroughPageFailurePresentationEvent
    extends WalkthroughPagePresentationEvent {
  final MentorXException exception;
  const WalkthroughPageFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class WalkthroughPageBloc
    extends Bloc<WalkthroughPageEvent, WalkthroughPageState>
    with
        BlocPresentationMixin<
          WalkthroughPageState,
          WalkthroughPagePresentationEvent
        > {
  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;

  WalkthroughPageBloc({
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  }) : _cacheRepository = cacheRepository,
       _analyticsService = analyticsService,
       super(WalkthroughPageState.initial) {
    on<WalkthroughPageSkipped>(_persistAndComplete);
    on<WalkthroughPageCompleted>(_persistAndComplete);
  }

  Future<void> _persistAndComplete(
    WalkthroughPageEvent event,
    Emitter<WalkthroughPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _cacheRepository.put(CacheKeys.hasSeenOnboarding, 'true');
      emit(state.copyWith(loadingState: LoadingState.loaded));
      _analyticsService.logEvent(
        name: event is WalkthroughPageSkipped
            ? AnalyticsEvents.walkthroughSkipped
            : AnalyticsEvents.walkthroughCompleted,
      );
      emitPresentation(const WalkthroughPageCompletedPresentationEvent());
    } catch (_) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
