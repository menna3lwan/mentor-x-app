part of 'assignment_detail_page_bloc.dart';

sealed class AssignmentDetailPageEvent extends Equatable {
  const AssignmentDetailPageEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentDetailPageLoadEvent extends AssignmentDetailPageEvent {
  final String assignmentId;
  const AssignmentDetailPageLoadEvent({required this.assignmentId});

  @override
  List<Object?> get props => [assignmentId];
}
