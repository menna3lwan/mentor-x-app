import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'walkthrough_event.dart';
part 'walkthrough_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class WalkthroughPresentationEvent {
  const WalkthroughPresentationEvent();
}

final class WalkthroughCompletedPresentationEvent
    extends WalkthroughPresentationEvent {
  const WalkthroughCompletedPresentationEvent();
}

final class WalkthroughFailurePresentationEvent
    extends WalkthroughPresentationEvent {
  final MentorXException exception;
  const WalkthroughFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class WalkthroughBloc
    extends Bloc<WalkthroughEvent, WalkthroughState>
    with
        BlocPresentationMixin<
          WalkthroughState,
          WalkthroughPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('WalkthroughBloc');

  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;

  WalkthroughBloc({
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  }) : _cacheRepository = cacheRepository,
       _analyticsService = analyticsService,
       super(WalkthroughState.initial) {
    on<WalkthroughSkipped>(_persistAndComplete);
    on<WalkthroughCompleted>(_persistAndComplete);
  }

  Future<void> _persistAndComplete(
    WalkthroughEvent event,
    Emitter<WalkthroughState> emit,
  ) async {
    _logger.info('_persistAndComplete entered');
    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _cacheRepository.put(CacheKeys.hasSeenOnboarding, 'true');
      emit(state.copyWith(loadingState: LoadingState.loaded));
      _analyticsService.logEvent(
        name: event is WalkthroughSkipped
            ? AnalyticsEvents.walkthroughSkipped
            : AnalyticsEvents.walkthroughCompleted,
      );
      _logger.info('_persistAndComplete success');
      emitPresentation(const WalkthroughCompletedPresentationEvent());
    } catch (e, s) {
      _logger.error('_persistAndComplete error', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
