import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_review_event.dart';
part 'quiz_review_state.dart';

sealed class QuizReviewPresentationEvent {
  const QuizReviewPresentationEvent();
}

final class QuizReviewNavigateBack extends QuizReviewPresentationEvent {
  const QuizReviewNavigateBack();
}

final class QuizReviewBloc
    extends Bloc<QuizReviewEvent, QuizReviewState>
    with
        BlocPresentationMixin<
          QuizReviewState,
          QuizReviewPresentationEvent
        > {
  QuizReviewBloc({
    required this.quizRepository,
    required this.analyticsService,
    required String quizId,
    required String attemptId,
    Map<String, String>? initialAnswers,
  }) : super(
          QuizReviewState(
            quizId: quizId,
            attemptId: attemptId,
            answers: initialAnswers ?? const {},
          ),
        ) {
    on<QuizReviewLoadEvent>(_onLoad);
    on<QuizReviewSubmitEvent>(_onSubmit);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizReviewLoadEvent event,
    Emitter<QuizReviewState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizReviewViewed);
    try {
      final questions = await quizRepository.getQuizQuestions(state.quizId);
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

  Future<void> _onSubmit(
    QuizReviewSubmitEvent event,
    Emitter<QuizReviewState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.actionInProgress));
    try {
      final result = await quizRepository.submitQuiz(
        state.quizId,
        answers: state.answers,
        attemptId: state.attemptId,
      );
      analyticsService.logEvent(
        name: 'quiz_submit_success',
        parameters: {
          'quiz_id': state.quizId,
          'attempt_id': state.attemptId,
          'score': result.score,
        },
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.success,
          result: result,
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
