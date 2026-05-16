import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_taking_page_event.dart';
part 'quiz_taking_page_state.dart';

sealed class QuizTakingPagePresentationEvent {
  const QuizTakingPagePresentationEvent();
}

final class QuizTakingPageNavigateBack extends QuizTakingPagePresentationEvent {
  const QuizTakingPageNavigateBack();
}

final class QuizTakingPageBloc
    extends Bloc<QuizTakingPageEvent, QuizTakingPageState>
    with
        BlocPresentationMixin<
          QuizTakingPageState,
          QuizTakingPagePresentationEvent
        > {
  static final MentorXLogger _log = MentorXLogger('QuizTakingPageBloc');

  QuizTakingPageBloc({
    required this.quizRepository,
    required this.analyticsService,
    required String quizId,
  }) : super(QuizTakingPageState(quizId: quizId)) {
    on<QuizTakingPageLoadEvent>(_onLoad);
    on<QuizTakingPageAnswerSelected>(_onAnswerSelected);
    on<QuizTakingPageNextQuestion>(_onNextQuestion);
    on<QuizTakingPagePreviousQuestion>(_onPreviousQuestion);
    on<QuizTakingPageSubmit>(_onSubmit);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizTakingPageLoadEvent event,
    Emitter<QuizTakingPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final [quiz, startResult] = await Future.wait([
        quizRepository.getQuiz(state.quizId),
        quizRepository.startQuiz(state.quizId),
      ]);

      final quizEntity = quiz as QuizEntity;
      final (attempt, questions) =
          startResult as (QuizAttemptEntity, List<QuizQuestionEntity>);

      int? remainingSeconds;
      if (quizEntity.timeRestricted) {
        if (attempt.expiresAt != null) {
          remainingSeconds = attempt.expiresAt!
              .difference(DateTime.now())
              .inSeconds;
        } else {
          remainingSeconds = quizEntity.durationMinutes * 60;
        }
        // Ensure we don't have negative time
        if (remainingSeconds < 0) remainingSeconds = 0;
      }

      analyticsService.logEvent(
        name: AnalyticsEvents.quizStarted,
        parameters: {
          AnalyticsParams.quizId: state.quizId,
          AnalyticsParams.name: quizEntity.title,
          'attempt_id': attempt.id,
          'remaining_seconds': remainingSeconds,
        },
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quiz: quizEntity,
          attemptId: attempt.id,
          questions: questions.isNotEmpty ? questions : quizEntity.questions,
          answers: attempt.answers,
          remainingSeconds: remainingSeconds,
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

  Future<void> _onAnswerSelected(
    QuizTakingPageAnswerSelected event,
    Emitter<QuizTakingPageState> emit,
  ) async {
    final newAnswers = Map<String, String>.from(state.answers);
    newAnswers[event.questionId] = event.selectedAnswer;
    emit(state.copyWith(answers: newAnswers));

    if (state.attemptId != null) {
      try {
        await quizRepository.saveAnswer(
          attemptId: state.attemptId!,
          questionId: event.questionId,
          selectedOptions: [event.selectedAnswer],
        );
      } catch (e) {
        // Optionally handle save error (e.g. show a toast)
        _log.warning('Failed to save answer: $e');
      }
    }
  }

  void _onNextQuestion(
    QuizTakingPageNextQuestion event,
    Emitter<QuizTakingPageState> emit,
  ) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
    }
  }

  void _onPreviousQuestion(
    QuizTakingPagePreviousQuestion event,
    Emitter<QuizTakingPageState> emit,
  ) {
    if (state.currentQuestionIndex > 0) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1),
      );
    }
  }

  Future<void> _onSubmit(
    QuizTakingPageSubmit event,
    Emitter<QuizTakingPageState> emit,
  ) async {
    if (state.attemptId == null) return;

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
