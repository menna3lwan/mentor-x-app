part of 'quiz_taking_page_bloc.dart';

sealed class QuizTakingPageEvent extends Equatable {
  const QuizTakingPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizTakingPageLoadEvent extends QuizTakingPageEvent {
  const QuizTakingPageLoadEvent();
}

final class QuizTakingPageAnswerSelected extends QuizTakingPageEvent {
  final String questionId;
  final String selectedAnswer;

  const QuizTakingPageAnswerSelected({
    required this.questionId,
    required this.selectedAnswer,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswer];
}

final class QuizTakingPageNextQuestion extends QuizTakingPageEvent {
  const QuizTakingPageNextQuestion();
}

final class QuizTakingPagePreviousQuestion extends QuizTakingPageEvent {
  const QuizTakingPagePreviousQuestion();
}

final class QuizTakingPageSubmit extends QuizTakingPageEvent {
  const QuizTakingPageSubmit();
}
