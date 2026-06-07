part of 'quiz_answers_review_bloc.dart';

sealed class QuizAnswersReviewEvent extends Equatable {
  const QuizAnswersReviewEvent();

  @override
  List<Object?> get props => [];
}

final class QuizAnswersReviewLoadEvent extends QuizAnswersReviewEvent {
  const QuizAnswersReviewLoadEvent();
}
