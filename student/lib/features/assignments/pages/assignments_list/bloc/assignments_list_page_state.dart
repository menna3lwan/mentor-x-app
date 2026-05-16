part of 'assignments_list_page_bloc.dart';

final class AssignmentsListPageState extends Equatable {
  final LoadingState loadingState;
  final List<AssignmentEntity> assignments;
  final String? errorMessage;

  const AssignmentsListPageState({
    this.loadingState = LoadingState.initial,
    this.assignments = const [],
    this.errorMessage,
  });

  static const initial = AssignmentsListPageState();

  @override
  List<Object?> get props => [loadingState, assignments, errorMessage];

  AssignmentsListPageState copyWith({
    LoadingState? loadingState,
    List<AssignmentEntity>? assignments,
    String? errorMessage,
  }) {
    return AssignmentsListPageState(
      loadingState: loadingState ?? this.loadingState,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
