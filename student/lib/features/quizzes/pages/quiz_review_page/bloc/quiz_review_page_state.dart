part of 'quiz_review_page_bloc.dart';

final class QuizReviewPageState extends Equatable {
  final LoadingState loadingState;

  const QuizReviewPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizReviewPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizReviewPageState copyWith({LoadingState? loadingState}) {
    return QuizReviewPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
