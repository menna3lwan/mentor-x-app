part of 'assignment_detail_bloc.dart';

final class AssignmentDetailState extends Equatable {
  final LoadingState loadingState;
  final AssignmentEntity? assignment;
  final AssignmentSubmissionEntity? submission;
  final String? errorMessage;

  const AssignmentDetailState({
    this.loadingState = LoadingState.initial,
    this.assignment,
    this.submission,
    this.errorMessage,
  });

  static const initial = AssignmentDetailState();

  @override
  List<Object?> get props => [
    loadingState,
    assignment,
    submission,
    errorMessage,
  ];

  AssignmentDetailState copyWith({
    LoadingState? loadingState,
    AssignmentEntity? assignment,
    AssignmentSubmissionEntity? submission,
    String? errorMessage,
  }) {
    return AssignmentDetailState(
      loadingState: loadingState ?? this.loadingState,
      assignment: assignment ?? this.assignment,
      submission: submission ?? this.submission,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
