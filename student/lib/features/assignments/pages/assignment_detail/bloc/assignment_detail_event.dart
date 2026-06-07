part of 'assignment_detail_bloc.dart';

sealed class AssignmentDetailEvent extends Equatable {
  const AssignmentDetailEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentDetailLoadEvent extends AssignmentDetailEvent {
  final String assignmentId;
  const AssignmentDetailLoadEvent({required this.assignmentId});

  @override
  List<Object?> get props => [assignmentId];
}
