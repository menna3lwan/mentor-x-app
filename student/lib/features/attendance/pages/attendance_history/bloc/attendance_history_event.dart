part of 'attendance_history_bloc.dart';

sealed class AttendanceHistoryEvent extends Equatable {
  const AttendanceHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceHistoryLoadEvent extends AttendanceHistoryEvent {
  const AttendanceHistoryLoadEvent();
}
