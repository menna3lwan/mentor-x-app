import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_answers_review_event.dart';
part 'quiz_answers_review_state.dart';

sealed class QuizAnswersReviewPresentationEvent {
  const QuizAnswersReviewPresentationEvent();
}

final class QuizAnswersReviewNavigateBack
    extends QuizAnswersReviewPresentationEvent {
  const QuizAnswersReviewNavigateBack();
}

final class QuizAnswersReviewBloc
    extends Bloc<QuizAnswersReviewEvent, QuizAnswersReviewState>
    with
        BlocPresentationMixin<
          QuizAnswersReviewState,
          QuizAnswersReviewPresentationEvent
        > {
  QuizAnswersReviewBloc({
    required this.quizRepository,
    required this.analyticsService,
    QuizAttemptEntity? attempt,
  }) : super(QuizAnswersReviewState(attempt: attempt)) {
    on<QuizAnswersReviewLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizAnswersReviewLoadEvent event,
    Emitter<QuizAnswersReviewState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizAnswersReviewViewed);
    
    if (state.attempt == null) {
      emit(state.copyWith(loadingState: LoadingState.loaded));
      return;
    }

    try {
      final questions = await quizRepository.getQuizQuestions(state.attempt!.quizId);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          questions: questions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
