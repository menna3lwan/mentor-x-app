part of 'assignment_result_page_bloc.dart';

final class AssignmentResultPageState extends Equatable {
  final String assignmentId;
  final LoadingState loadingState;
  final AssignmentSubmissionEntity? submission;
  final String? errorMessage;

  const AssignmentResultPageState({
    required this.assignmentId,
    this.loadingState = LoadingState.initial,
    this.submission,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    assignmentId,
    loadingState,
    submission,
    errorMessage,
  ];

  AssignmentResultPageState copyWith({
    LoadingState? loadingState,
    AssignmentSubmissionEntity? submission,
    String? errorMessage,
  }) {
    return AssignmentResultPageState(
      assignmentId: assignmentId,
      loadingState: loadingState ?? this.loadingState,
      submission: submission ?? this.submission,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
