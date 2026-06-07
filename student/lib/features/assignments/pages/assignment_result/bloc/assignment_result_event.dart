part of 'assignment_result_bloc.dart';

sealed class AssignmentResultEvent extends Equatable {
  const AssignmentResultEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentResultLoadEvent extends AssignmentResultEvent {
  const AssignmentResultLoadEvent();
}
