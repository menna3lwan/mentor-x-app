part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceStarted extends AttendanceEvent {
  final String childId;
  const AttendanceStarted(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class AttendanceRefreshRequested extends AttendanceEvent {
  final String childId;
  const AttendanceRefreshRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class AttendanceRetrySectionRequested extends AttendanceEvent {
  final AttendanceSection section;
  const AttendanceRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
