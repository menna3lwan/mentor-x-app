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
  static final MentorXLogger _logger = MentorXLogger('QuizAnswersReviewBloc');

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
    _logger.info('_onLoad entered');
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizAnswersReviewViewed);
    
    if (state.attempt == null) {
      _logger.info('_onLoad completed: no attempt provided in state');
      emit(state.copyWith(loadingState: LoadingState.loaded));
      return;
    }

    try {
      final questions = await quizRepository.getQuizQuestions(state.attempt!.quizId);
      _logger.info('_onLoad success: loaded ${questions.length} questions for quizId: ${state.attempt!.quizId}');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          questions: questions,
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
