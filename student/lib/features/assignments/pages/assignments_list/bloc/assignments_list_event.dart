part of 'assignments_list_bloc.dart';

sealed class AssignmentsListEvent {
  const AssignmentsListEvent();
}

final class AssignmentsListLoadEvent extends AssignmentsListEvent {
  const AssignmentsListLoadEvent();
}

final class AssignmentsListRefreshEvent extends AssignmentsListEvent {
  const AssignmentsListRefreshEvent();
}
