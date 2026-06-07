import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_result_event.dart';
part 'quiz_result_state.dart';

sealed class QuizResultPresentationEvent {
  const QuizResultPresentationEvent();
}

final class QuizResultNavigateBack extends QuizResultPresentationEvent {
  const QuizResultNavigateBack();
}

final class QuizResultBloc
    extends Bloc<QuizResultEvent, QuizResultState>
    with
        BlocPresentationMixin<
          QuizResultState,
          QuizResultPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('QuizResultBloc');

  QuizResultBloc({
    required this.quizRepository,
    required this.leaderboardRepository,
    required this.analyticsService,
  }) : super(QuizResultState.initial) {
    on<QuizResultLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final LeaderboardRepository leaderboardRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizResultLoadEvent event,
    Emitter<QuizResultState> emit,
  ) async {
    _logger.info('_onLoad entered with attemptId: ${event.attemptId}');
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    analyticsService.logEvent(name: AnalyticsEvents.quizResultViewed);
    try {
      final result = await quizRepository.getResults(event.attemptId);

      // Fetch leaderboard data in parallel
      final [myRank, leaderboard] = await Future.wait([
        leaderboardRepository.getMyQuizRank(result.quizId),
        leaderboardRepository.getQuizLeaderboard(result.quizId),
      ]);

      _logger.info('_onLoad success: loaded attempt score: ${result.score}');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          result: result,
          myRank: myRank as LeaderboardEntryEntity?,
          leaderboard: leaderboard as List<LeaderboardEntryEntity>,
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoad error', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
