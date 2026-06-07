part of 'assignment_submit_bloc.dart';

sealed class AssignmentSubmitEvent extends Equatable {
  const AssignmentSubmitEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentSubmitLoadEvent extends AssignmentSubmitEvent {
  const AssignmentSubmitLoadEvent();
}

final class AssignmentSubmitAnswerSelected
    extends AssignmentSubmitEvent {
  final String questionId;
  final String selectedAnswer;

  const AssignmentSubmitAnswerSelected({
    required this.questionId,
    required this.selectedAnswer,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswer];
}

final class AssignmentSubmitNextQuestion extends AssignmentSubmitEvent {
  const AssignmentSubmitNextQuestion();
}

final class AssignmentSubmitPreviousQuestion
    extends AssignmentSubmitEvent {
  const AssignmentSubmitPreviousQuestion();
}

final class AssignmentSubmitSubmit extends AssignmentSubmitEvent {
  const AssignmentSubmitSubmit();
}

final class AssignmentSubmitFileAdded extends AssignmentSubmitEvent {
  final String filePath;
  const AssignmentSubmitFileAdded(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

final class AssignmentSubmitFileRemoved extends AssignmentSubmitEvent {
  final String filePath;
  const AssignmentSubmitFileRemoved(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

final class AssignmentSubmitContentChanged
    extends AssignmentSubmitEvent {
  final String content;
  const AssignmentSubmitContentChanged(this.content);
  @override
  List<Object?> get props => [content];
}
