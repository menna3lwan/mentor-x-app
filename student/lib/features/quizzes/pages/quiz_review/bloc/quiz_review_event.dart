part of 'quiz_review_bloc.dart';

sealed class QuizReviewEvent extends Equatable {
  const QuizReviewEvent();

  @override
  List<Object?> get props => [];
}

final class QuizReviewLoadEvent extends QuizReviewEvent {
  const QuizReviewLoadEvent();
}

final class QuizReviewSubmitEvent extends QuizReviewEvent {
  const QuizReviewSubmitEvent();
}
