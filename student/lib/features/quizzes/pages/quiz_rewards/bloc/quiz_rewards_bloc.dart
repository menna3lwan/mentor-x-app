import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_rewards_event.dart';
part 'quiz_rewards_state.dart';

sealed class QuizRewardsPresentationEvent {
  const QuizRewardsPresentationEvent();
}

final class QuizRewardsNavigateBack
    extends QuizRewardsPresentationEvent {
  const QuizRewardsNavigateBack();
}

final class QuizRewardsBloc
    extends Bloc<QuizRewardsEvent, QuizRewardsState>
    with
        BlocPresentationMixin<
          QuizRewardsState,
          QuizRewardsPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('QuizRewardsBloc');

  QuizRewardsBloc({
    required this.quizRepository,
    required this.leaderboardRepository,
    required this.analyticsService,
  }) : super(QuizRewardsState.initial) {
    on<QuizRewardsLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final LeaderboardRepository leaderboardRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizRewardsLoadEvent event,
    Emitter<QuizRewardsState> emit,
  ) async {
    _logger.info('_onLoad entered');
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizRewardsViewed);
    try {
      final entries = await leaderboardRepository.getGlobalLeaderboard();
      _logger.info('_onLoad success: loaded ${entries.length} leaderboard entries');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          leaderboardEntries: entries,
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoad error', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
