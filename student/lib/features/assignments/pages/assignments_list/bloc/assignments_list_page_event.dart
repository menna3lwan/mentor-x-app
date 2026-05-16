part of 'assignments_list_page_bloc.dart';

sealed class AssignmentsListPageEvent {
  const AssignmentsListPageEvent();
}

final class AssignmentsListPageLoadEvent extends AssignmentsListPageEvent {
  const AssignmentsListPageLoadEvent();
}

final class AssignmentsListPageRefreshEvent extends AssignmentsListPageEvent {
  const AssignmentsListPageRefreshEvent();
}
