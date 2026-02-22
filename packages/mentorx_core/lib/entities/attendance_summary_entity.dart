part of '../mentorx_core.dart';

final class AttendanceSummaryEntity extends Equatable {
  final int totalSessions;
  final int present;
  final int late;
  final int absent;
  final int excused;
  final double attendanceRate;

  const AttendanceSummaryEntity({
    required this.totalSessions,
    required this.present,
    required this.late,
    required this.absent,
    required this.excused,
    required this.attendanceRate,
  });

  @override
  List<Object?> get props => [
        totalSessions,
        present,
        late,
        absent,
        excused,
        attendanceRate,
      ];
}
