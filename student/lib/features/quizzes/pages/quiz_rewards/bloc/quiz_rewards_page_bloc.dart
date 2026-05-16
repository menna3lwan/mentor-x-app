import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_rewards_page_event.dart';
part 'quiz_rewards_page_state.dart';

sealed class QuizRewardsPagePresentationEvent {
  const QuizRewardsPagePresentationEvent();
}

final class QuizRewardsPageNavigateBack
    extends QuizRewardsPagePresentationEvent {
  const QuizRewardsPageNavigateBack();
}

final class QuizRewardsPageBloc
    extends Bloc<QuizRewardsPageEvent, QuizRewardsPageState>
    with
        BlocPresentationMixin<
          QuizRewardsPageState,
          QuizRewardsPagePresentationEvent
        > {
  QuizRewardsPageBloc({
    required this.quizRepository,
    required this.leaderboardRepository,
    required this.analyticsService,
  }) : super(QuizRewardsPageState.initial) {
    on<QuizRewardsPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final LeaderboardRepository leaderboardRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizRewardsPageLoadEvent event,
    Emitter<QuizRewardsPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizRewardsViewed);
    try {
      final entries = await leaderboardRepository.getGlobalLeaderboard();
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          leaderboardEntries: entries,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
