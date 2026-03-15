part of 'assignment_result_page_bloc.dart';

sealed class AssignmentResultPageEvent extends Equatable {
  const AssignmentResultPageEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentResultPageLoadEvent extends AssignmentResultPageEvent {
  const AssignmentResultPageLoadEvent();
}
