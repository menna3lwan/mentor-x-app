part of 'quiz_review_page_bloc.dart';

final class QuizReviewPageState extends Equatable {
  final LoadingState loadingState;
  final String quizId;
  final String attemptId;
  final List<QuizQuestionEntity> questions;
  final Map<String, String> answers;
  final String? errorMessage;
  final QuizAttemptEntity? result;

  const QuizReviewPageState({
    this.loadingState = LoadingState.initial,
    this.quizId = '',
    this.attemptId = '',
    this.questions = const [],
    this.answers = const {},
    this.errorMessage,
    this.result,
  });

  static const initial = QuizReviewPageState();

  @override
  List<Object?> get props => [
        loadingState,
        quizId,
        attemptId,
        questions,
        answers,
        errorMessage,
        result,
      ];

  QuizReviewPageState copyWith({
    LoadingState? loadingState,
    String? quizId,
    String? attemptId,
    List<QuizQuestionEntity>? questions,
    Map<String, String>? answers,
    String? errorMessage,
    QuizAttemptEntity? result,
  }) {
    return QuizReviewPageState(
      loadingState: loadingState ?? this.loadingState,
      quizId: quizId ?? this.quizId,
      attemptId: attemptId ?? this.attemptId,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      errorMessage: errorMessage ?? this.errorMessage,
      result: result ?? this.result,
    );
  }
}
