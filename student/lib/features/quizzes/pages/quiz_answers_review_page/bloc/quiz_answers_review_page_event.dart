part of 'quiz_answers_review_page_bloc.dart';

sealed class QuizAnswersReviewPageEvent extends Equatable {
  const QuizAnswersReviewPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizAnswersReviewPageLoadEvent extends QuizAnswersReviewPageEvent {
  const QuizAnswersReviewPageLoadEvent();
}
