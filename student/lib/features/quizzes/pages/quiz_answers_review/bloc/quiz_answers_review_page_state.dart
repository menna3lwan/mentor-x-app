part of 'quiz_answers_review_page_bloc.dart';

final class QuizAnswersReviewPageState extends Equatable {
  final LoadingState loadingState;
  final QuizAttemptEntity? attempt;
  final List<QuizQuestionEntity> questions;
  final String? errorMessage;

  const QuizAnswersReviewPageState({
    this.loadingState = LoadingState.initial,
    this.attempt,
    this.questions = const [],
    this.errorMessage,
  });

  static const initial = QuizAnswersReviewPageState();

  @override
  List<Object?> get props => [loadingState, attempt, questions, errorMessage];

  QuizAnswersReviewPageState copyWith({
    LoadingState? loadingState,
    QuizAttemptEntity? attempt,
    List<QuizQuestionEntity>? questions,
    String? errorMessage,
  }) {
    return QuizAnswersReviewPageState(
      loadingState: loadingState ?? this.loadingState,
      attempt: attempt ?? this.attempt,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
