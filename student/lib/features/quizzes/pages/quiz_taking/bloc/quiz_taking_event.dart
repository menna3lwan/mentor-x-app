part of 'quiz_taking_bloc.dart';

sealed class QuizTakingEvent extends Equatable {
  const QuizTakingEvent();

  @override
  List<Object?> get props => [];
}

final class QuizTakingLoadEvent extends QuizTakingEvent {
  const QuizTakingLoadEvent();
}

final class QuizTakingAnswerSelected extends QuizTakingEvent {
  final String questionId;
  final String selectedAnswer;

  const QuizTakingAnswerSelected({
    required this.questionId,
    required this.selectedAnswer,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswer];
}

final class QuizTakingNextQuestion extends QuizTakingEvent {
  const QuizTakingNextQuestion();
}

final class QuizTakingPreviousQuestion extends QuizTakingEvent {
  const QuizTakingPreviousQuestion();
}

final class QuizTakingSubmit extends QuizTakingEvent {
  const QuizTakingSubmit();
}

final class QuizTakingJumpToQuestion extends QuizTakingEvent {
  final int index;
  const QuizTakingJumpToQuestion(this.index);

  @override
  List<Object?> get props => [index];
}
