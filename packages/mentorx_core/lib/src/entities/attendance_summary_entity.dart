part of '../../mentorx_core.dart';

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


  static final placeholder = AttendanceSummaryEntity(
    totalSessions: 0,
    present: 0,
    late: 0,
    absent: 0,
    excused: 0,
    attendanceRate: 0.0,
  );
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
