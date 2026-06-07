import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_taking_event.dart';
part 'quiz_taking_state.dart';

sealed class QuizTakingPresentationEvent {
  const QuizTakingPresentationEvent();
}

final class QuizTakingNavigateBack extends QuizTakingPresentationEvent {
  const QuizTakingNavigateBack();
}

final class QuizTakingBloc
    extends Bloc<QuizTakingEvent, QuizTakingState>
    with
        BlocPresentationMixin<
          QuizTakingState,
          QuizTakingPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('QuizTakingBloc');

  QuizTakingBloc({
    required this.quizRepository,
    required this.analyticsService,
    required String quizId,
  }) : super(QuizTakingState(quizId: quizId)) {
    on<QuizTakingLoadEvent>(_onLoad);
    on<QuizTakingAnswerSelected>(_onAnswerSelected);
    on<QuizTakingNextQuestion>(_onNextQuestion);
    on<QuizTakingPreviousQuestion>(_onPreviousQuestion);
    on<QuizTakingSubmit>(_onSubmit);
    on<QuizTakingJumpToQuestion>((event, emit) {
      _logger.info('QuizTakingJumpToQuestion: jump to index ${event.index}');
      if (event.index >= 0 && event.index < state.questions.length) {
        emit(state.copyWith(currentQuestionIndex: event.index));
      }
    });
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizTakingLoadEvent event,
    Emitter<QuizTakingState> emit,
  ) async {
    _logger.info('_onLoad entered for quizId: ${state.quizId}');
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final quizEntity = await quizRepository.getQuiz(state.quizId);
      QuizAttemptEntity attempt;
      List<QuizQuestionEntity> questions;

      try {
        final startResult = await quizRepository.startQuiz(state.quizId);
        attempt = startResult.$1;
        questions = startResult.$2;
      } on QuizRepositoryException catch (e) {
        if (e.code == QuizRepositoryExceptionCode.quizAlreadyStarted) {
          _logger.info('_onLoad: quiz already started, fetching active attempt');
          final activeAttempt = await quizRepository.getStudentAttemptForQuiz('', state.quizId);
          if (activeAttempt == null) {
            _logger.warning('_onLoad: quiz already attempted but active attempt not found');
            emit(
              state.copyWith(
                loadingState: LoadingState.error,
                errorMessage: 'alreadyAttempted',
              ),
            );
            return;
          }
          attempt = activeAttempt;
          questions = await quizRepository.getQuizQuestions(state.quizId);
        } else {
          rethrow;
        }
      }

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

      _logger.info('_onLoad success: quiz loaded, attemptId: ${attempt.id}, questions: ${questions.length}');
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

  Future<void> _onAnswerSelected(
    QuizTakingAnswerSelected event,
    Emitter<QuizTakingState> emit,
  ) async {
    _logger.info('_onAnswerSelected: question ${event.questionId} -> ${event.selectedAnswer}');
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
        _logger.info('_onAnswerSelected success: answer saved on server');
      } catch (e, s) {
        // Optionally handle save error (e.g. show a toast)
        _logger.error('Failed to save answer', e, s);
      }
    }
  }

  void _onNextQuestion(
    QuizTakingNextQuestion event,
    Emitter<QuizTakingState> emit,
  ) {
    _logger.info('_onNextQuestion');
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
    }
  }

  void _onPreviousQuestion(
    QuizTakingPreviousQuestion event,
    Emitter<QuizTakingState> emit,
  ) {
    _logger.info('_onPreviousQuestion');
    if (state.currentQuestionIndex > 0) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1),
      );
    }
  }

  Future<void> _onSubmit(
    QuizTakingSubmit event,
    Emitter<QuizTakingState> emit,
  ) async {
    _logger.info('_onSubmit entered for attemptId: ${state.attemptId}');
    if (state.attemptId == null) {
      _logger.warning('_onSubmit: cannot submit, attemptId is null');
      return;
    }

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
      _logger.info('_onSubmit success: quiz submitted, score: ${result.score}');
      emit(
        state.copyWith(
          loadingState: LoadingState.success,
          result: result,
        ),
      );
    } catch (e, s) {
      _logger.error('_onSubmit error', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
