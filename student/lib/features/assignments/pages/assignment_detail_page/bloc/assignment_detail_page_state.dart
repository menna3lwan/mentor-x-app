part of 'assignment_detail_page_bloc.dart';

final class AssignmentDetailPageState extends Equatable {
  final LoadingState loadingState;
  final AssignmentEntity? assignment;
  final AssignmentSubmissionEntity? submission;
  final String? errorMessage;

  const AssignmentDetailPageState({
    this.loadingState = LoadingState.initial,
    this.assignment,
    this.submission,
    this.errorMessage,
  });

  static const initial = AssignmentDetailPageState();

  @override
  List<Object?> get props => [
    loadingState,
    assignment,
    submission,
    errorMessage,
  ];

  AssignmentDetailPageState copyWith({
    LoadingState? loadingState,
    AssignmentEntity? assignment,
    AssignmentSubmissionEntity? submission,
    String? errorMessage,
  }) {
    return AssignmentDetailPageState(
      loadingState: loadingState ?? this.loadingState,
      assignment: assignment ?? this.assignment,
      submission: submission ?? this.submission,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
