part of 'quiz_answers_review_bloc.dart';

final class QuizAnswersReviewState extends Equatable {
  final LoadingState loadingState;
  final QuizAttemptEntity? attempt;
  final List<QuizQuestionEntity> questions;
  final String? errorMessage;

  const QuizAnswersReviewState({
    this.loadingState = LoadingState.initial,
    this.attempt,
    this.questions = const [],
    this.errorMessage,
  });

  static const initial = QuizAnswersReviewState();

  @override
  List<Object?> get props => [loadingState, attempt, questions, errorMessage];

  QuizAnswersReviewState copyWith({
    LoadingState? loadingState,
    QuizAttemptEntity? attempt,
    List<QuizQuestionEntity>? questions,
    String? errorMessage,
  }) {
    return QuizAnswersReviewState(
      loadingState: loadingState ?? this.loadingState,
      attempt: attempt ?? this.attempt,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
