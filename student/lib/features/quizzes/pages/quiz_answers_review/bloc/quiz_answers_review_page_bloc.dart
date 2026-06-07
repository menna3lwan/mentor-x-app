import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_answers_review_page_event.dart';
part 'quiz_answers_review_page_state.dart';

sealed class QuizAnswersReviewPagePresentationEvent {
  const QuizAnswersReviewPagePresentationEvent();
}

final class QuizAnswersReviewPageNavigateBack
    extends QuizAnswersReviewPagePresentationEvent {
  const QuizAnswersReviewPageNavigateBack();
}

final class QuizAnswersReviewPageBloc
    extends Bloc<QuizAnswersReviewPageEvent, QuizAnswersReviewPageState>
    with
        BlocPresentationMixin<
          QuizAnswersReviewPageState,
          QuizAnswersReviewPagePresentationEvent
        > {
  QuizAnswersReviewPageBloc({
    required this.quizRepository,
    required this.analyticsService,
    QuizAttemptEntity? attempt,
  }) : super(QuizAnswersReviewPageState(attempt: attempt)) {
    on<QuizAnswersReviewPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizAnswersReviewPageLoadEvent event,
    Emitter<QuizAnswersReviewPageState> emit,
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
