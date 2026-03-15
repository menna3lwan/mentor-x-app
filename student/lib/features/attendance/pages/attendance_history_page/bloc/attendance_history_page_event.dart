part of 'attendance_history_page_bloc.dart';

sealed class AttendanceHistoryPageEvent extends Equatable {
  const AttendanceHistoryPageEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceHistoryPageLoadEvent extends AttendanceHistoryPageEvent {
  const AttendanceHistoryPageLoadEvent();
}
