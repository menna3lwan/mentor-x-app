part of 'assignment_submit_page_bloc.dart';

sealed class AssignmentSubmitPageEvent extends Equatable {
  const AssignmentSubmitPageEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentSubmitPageLoadEvent extends AssignmentSubmitPageEvent {
  const AssignmentSubmitPageLoadEvent();
}

final class AssignmentSubmitPageAnswerSelected extends AssignmentSubmitPageEvent {
  final String questionId;
  final String selectedAnswer;

  const AssignmentSubmitPageAnswerSelected({
    required this.questionId,
    required this.selectedAnswer,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswer];
}

final class AssignmentSubmitPageNextQuestion extends AssignmentSubmitPageEvent {
  const AssignmentSubmitPageNextQuestion();
}

final class AssignmentSubmitPagePreviousQuestion extends AssignmentSubmitPageEvent {
  const AssignmentSubmitPagePreviousQuestion();
}

final class AssignmentSubmitPageSubmit extends AssignmentSubmitPageEvent {
  const AssignmentSubmitPageSubmit();
}

final class AssignmentSubmitPageFileAdded extends AssignmentSubmitPageEvent {
  final String filePath;
  const AssignmentSubmitPageFileAdded(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

final class AssignmentSubmitPageFileRemoved extends AssignmentSubmitPageEvent {
  final String filePath;
  const AssignmentSubmitPageFileRemoved(this.filePath);
  @override
  List<Object?> get props => [filePath];
}

final class AssignmentSubmitPageContentChanged extends AssignmentSubmitPageEvent {
  final String content;
  const AssignmentSubmitPageContentChanged(this.content);
  @override
  List<Object?> get props => [content];
}
