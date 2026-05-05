part of 'quiz_taking_page_bloc.dart';

final class QuizTakingPageState extends Equatable {
  final String quizId;
  final LoadingState loadingState;
  final QuizEntity? quiz;
  final List<QuizQuestionEntity> questions;
  final int currentQuestionIndex;
  final Map<String, String> answers;
  final QuizAttemptEntity? result;
  final String? errorMessage;

  const QuizTakingPageState({
    required this.quizId,
    this.loadingState = LoadingState.initial,
    this.quiz,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.answers = const {},
    this.result,
    this.errorMessage,
  });

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;
  bool get isSubmitting => loadingState.isActionInProgress;
  bool get isSuccess => loadingState.isSuccess;

  QuizQuestionEntity? get currentQuestion =>
      questions.isNotEmpty ? questions[currentQuestionIndex] : null;

  @override
  List<Object?> get props => [
    quizId,
    loadingState,
    quiz,
    questions,
    currentQuestionIndex,
    answers,
    result,
    errorMessage,
  ];

  QuizTakingPageState copyWith({
    String? quizId,
    LoadingState? loadingState,
    QuizEntity? quiz,
    List<QuizQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<String, String>? answers,
    QuizAttemptEntity? result,
    String? errorMessage,
  }) {
    return QuizTakingPageState(
      quizId: quizId ?? this.quizId,
      loadingState: loadingState ?? this.loadingState,
      quiz: quiz ?? this.quiz,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
