part of 'assignment_result_bloc.dart';

final class AssignmentResultState extends Equatable {
  final String assignmentId;
  final LoadingState loadingState;
  final AssignmentSubmissionEntity? submission;
  final String? errorMessage;

  const AssignmentResultState({
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

  AssignmentResultState copyWith({
    LoadingState? loadingState,
    AssignmentSubmissionEntity? submission,
    String? errorMessage,
  }) {
    return AssignmentResultState(
      assignmentId: assignmentId,
      loadingState: loadingState ?? this.loadingState,
      submission: submission ?? this.submission,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
