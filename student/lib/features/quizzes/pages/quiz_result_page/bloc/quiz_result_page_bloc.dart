import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_result_page_event.dart';
part 'quiz_result_page_state.dart';

sealed class QuizResultPagePresentationEvent {
  const QuizResultPagePresentationEvent();
}

final class QuizResultPageNavigateBack extends QuizResultPagePresentationEvent {
  const QuizResultPageNavigateBack();
}

final class QuizResultPageBloc
    extends Bloc<QuizResultPageEvent, QuizResultPageState>
    with
        BlocPresentationMixin<
          QuizResultPageState,
          QuizResultPagePresentationEvent
        > {
  QuizResultPageBloc({
    required this.quizRepository,
    required this.leaderboardRepository,
  }) : super(QuizResultPageState.initial) {
    on<QuizResultPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final LeaderboardRepository leaderboardRepository;

  Future<void> _onLoad(
    QuizResultPageLoadEvent event,
    Emitter<QuizResultPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading, errorMessage: null));
    try {
      final result = await quizRepository.getResults(event.attemptId);

      // Fetch leaderboard data in parallel
      final [myRank, leaderboard] = await Future.wait([
        leaderboardRepository.getMyQuizRank(result.quizId),
        leaderboardRepository.getQuizLeaderboard(result.quizId),
      ]);

      emit(state.copyWith(
        loadingState: LoadingState.loaded,
        result: result,
        myRank: myRank as LeaderboardEntryEntity?,
        leaderboard: leaderboard as List<LeaderboardEntryEntity>,
      ));
    } catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
