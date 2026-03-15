part of 'quiz_answers_review_page_bloc.dart';

final class QuizAnswersReviewPageState extends Equatable {
  final LoadingState loadingState;

  const QuizAnswersReviewPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizAnswersReviewPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizAnswersReviewPageState copyWith({LoadingState? loadingState}) {
    return QuizAnswersReviewPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
