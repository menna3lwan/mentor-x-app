part of 'quiz_review_page_bloc.dart';

sealed class QuizReviewPageEvent extends Equatable {
  const QuizReviewPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizReviewPageLoadEvent extends QuizReviewPageEvent {
  const QuizReviewPageLoadEvent();
}
