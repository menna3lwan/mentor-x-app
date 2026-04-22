part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object?> get props => [];
}

class AttendanceStarted extends AttendanceEvent {
  final String childId;
  const AttendanceStarted(this.childId);
  @override
  List<Object?> get props => [childId];
}

class AttendanceRefreshRequested extends AttendanceEvent {
  final String childId;
  const AttendanceRefreshRequested(this.childId);
  @override
  List<Object?> get props => [childId];
}
