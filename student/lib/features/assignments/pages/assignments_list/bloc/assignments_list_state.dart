part of 'assignments_list_bloc.dart';

final class AssignmentsListState extends Equatable {
  final LoadingState loadingState;
  final List<AssignmentEntity> assignments;
  final String? errorMessage;

  const AssignmentsListState({
    this.loadingState = LoadingState.initial,
    this.assignments = const [],
    this.errorMessage,
  });

  static const initial = AssignmentsListState();

  @override
  List<Object?> get props => [loadingState, assignments, errorMessage];

  AssignmentsListState copyWith({
    LoadingState? loadingState,
    List<AssignmentEntity>? assignments,
    String? errorMessage,
  }) {
    return AssignmentsListState(
      loadingState: loadingState ?? this.loadingState,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
