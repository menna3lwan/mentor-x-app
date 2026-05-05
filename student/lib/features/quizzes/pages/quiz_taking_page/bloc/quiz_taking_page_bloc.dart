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
  QuizTakingPageBloc({
    required this.quizRepository,
    required String quizId,
  }) : super(QuizTakingPageState(quizId: quizId)) {
    on<QuizTakingPageLoadEvent>(_onLoad);
    on<QuizTakingPageAnswerSelected>(_onAnswerSelected);
    on<QuizTakingPageNextQuestion>(_onNextQuestion);
    on<QuizTakingPagePreviousQuestion>(_onPreviousQuestion);
    on<QuizTakingPageSubmit>(_onSubmit);
  }

  final QuizRepository quizRepository;

  Future<void> _onLoad(
    QuizTakingPageLoadEvent event,
    Emitter<QuizTakingPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final quiz = await quizRepository.getQuiz(state.quizId);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quiz: quiz,
          questions: quiz.questions,
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

  void _onAnswerSelected(
    QuizTakingPageAnswerSelected event,
    Emitter<QuizTakingPageState> emit,
  ) {
    final newAnswers = Map<String, String>.from(state.answers);
    newAnswers[event.questionId] = event.selectedAnswer;
    emit(state.copyWith(answers: newAnswers));
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
    emit(state.copyWith(loadingState: LoadingState.actionInProgress));
    try {
      final result = await quizRepository.submitQuiz(
        state.quizId,
        answers: state.answers,
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
