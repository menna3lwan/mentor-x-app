part of 'quiz_taking_page_bloc.dart';

final class QuizTakingPageState extends Equatable {
  final String quizId;
  final String? attemptId;
  final LoadingState loadingState;
  final QuizEntity? quiz;
  final List<QuizQuestionEntity> questions;
  final int currentQuestionIndex;
  final Map<String, String> answers;
  final int? remainingSeconds;
  final QuizAttemptEntity? result;
  final String? errorMessage;

  const QuizTakingPageState({
    required this.quizId,
    this.attemptId,
    this.loadingState = LoadingState.initial,
    this.quiz,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.answers = const {},
    this.remainingSeconds,
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
    attemptId,
    loadingState,
    quiz,
    questions,
    currentQuestionIndex,
    answers,
    remainingSeconds,
    result,
    errorMessage,
  ];

  QuizTakingPageState copyWith({
    String? quizId,
    String? attemptId,
    LoadingState? loadingState,
    QuizEntity? quiz,
    List<QuizQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<String, String>? answers,
    int? remainingSeconds,
    QuizAttemptEntity? result,
    String? errorMessage,
  }) {
    return QuizTakingPageState(
      quizId: quizId ?? this.quizId,
      attemptId: attemptId ?? this.attemptId,
      loadingState: loadingState ?? this.loadingState,
      quiz: quiz ?? this.quiz,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
