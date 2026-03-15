part of 'assignment_result_page_bloc.dart';

final class AssignmentResultPageState extends Equatable {
  final LoadingState loadingState;

  const AssignmentResultPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AssignmentResultPageState();

  @override
  List<Object?> get props => [loadingState];

  AssignmentResultPageState copyWith({LoadingState? loadingState}) {
    return AssignmentResultPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
