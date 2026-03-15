part of 'assignment_submit_page_bloc.dart';

final class AssignmentSubmitPageState extends Equatable {
  final LoadingState loadingState;

  const AssignmentSubmitPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AssignmentSubmitPageState();

  @override
  List<Object?> get props => [loadingState];

  AssignmentSubmitPageState copyWith({LoadingState? loadingState}) {
    return AssignmentSubmitPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
