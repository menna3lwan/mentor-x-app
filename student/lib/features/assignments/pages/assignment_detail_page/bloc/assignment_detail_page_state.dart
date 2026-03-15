part of 'assignment_detail_page_bloc.dart';

final class AssignmentDetailPageState extends Equatable {
  final LoadingState loadingState;

  const AssignmentDetailPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AssignmentDetailPageState();

  @override
  List<Object?> get props => [loadingState];

  AssignmentDetailPageState copyWith({LoadingState? loadingState}) {
    return AssignmentDetailPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
