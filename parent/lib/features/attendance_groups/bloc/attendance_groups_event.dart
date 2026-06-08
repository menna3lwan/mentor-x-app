part of 'attendance_groups_bloc.dart';

sealed class AttendanceGroupsEvent extends Equatable {
  const AttendanceGroupsEvent();

  @override
  List<Object?> get props => const [];
}

final class AttendanceGroupsStarted extends AttendanceGroupsEvent {
  final String childId;
  const AttendanceGroupsStarted(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class AttendanceGroupsRefreshRequested extends AttendanceGroupsEvent {
  final String childId;
  const AttendanceGroupsRefreshRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}
