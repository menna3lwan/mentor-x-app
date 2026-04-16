part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceStarted extends AttendanceEvent {
  final String? childId;

  const AttendanceStarted({this.childId});

  @override
  List<Object?> get props => [childId];
}
