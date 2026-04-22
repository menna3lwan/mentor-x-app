part of 'attendance_bloc.dart';

enum AttendanceBlocStatus { initial, loading, success, failure }

class AttendanceState extends Equatable {
  final AttendanceBlocStatus status;
  final List<AttendanceRecordEntity> attendanceRecords;
  final AttendanceSummaryEntity? attendanceSummary;
  final String? errorMessage;

  const AttendanceState({
    this.status = AttendanceBlocStatus.initial,
    this.attendanceRecords = const [],
    this.attendanceSummary,
    this.errorMessage,
  });

  AttendanceState copyWith({
    AttendanceBlocStatus? status,
    List<AttendanceRecordEntity>? attendanceRecords,
    AttendanceSummaryEntity? attendanceSummary,
    String? errorMessage,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      attendanceRecords: attendanceRecords ?? this.attendanceRecords,
      attendanceSummary: attendanceSummary ?? this.attendanceSummary,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, attendanceRecords, attendanceSummary, errorMessage];
}
