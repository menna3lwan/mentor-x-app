part of 'quiz_taking_page_bloc.dart';

sealed class QuizTakingPageEvent extends Equatable {
  const QuizTakingPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizTakingPageLoadEvent extends QuizTakingPageEvent {
  const QuizTakingPageLoadEvent();
}
