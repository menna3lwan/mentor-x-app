part of 'package:mentorx_core/mentorx_core.dart';


base class AttendanceSummaryEntity extends Equatable {
  final int totalSessions;
  final int present;
  final int absent;
  final int late;
  final int excused;
  final int online;
  final double attendanceRate;
  final double punctualityRate;
  final DateTime? periodFrom;
  final DateTime? periodTo;
  final List<AttendanceRecordEntity> recentRecords;

  const AttendanceSummaryEntity({
    required this.totalSessions,
    required this.present,
    required this.absent,
    required this.late,
    required this.excused,
    required this.attendanceRate,
    this.online = 0,
    this.punctualityRate = 0.0,
    this.periodFrom,
    this.periodTo,
    this.recentRecords = const [],
  });

  static const placeholder = AttendanceSummaryEntity(
    totalSessions: 0,
    present: 0,
    absent: 0,
    late: 0,
    excused: 0,
    attendanceRate: 0.0,
  );

  @override
  List<Object?> get props => [
        totalSessions,
        present,
        absent,
        late,
        excused,
        online,
        attendanceRate,
        punctualityRate,
        periodFrom,
        periodTo,
        recentRecords,
      ];

  AttendanceSummaryEntity copyWith({
    int? totalSessions,
    int? present,
    int? absent,
    int? late,
    int? excused,
    int? online,
    double? attendanceRate,
    double? punctualityRate,
    DateTime? periodFrom,
    DateTime? periodTo,
    List<AttendanceRecordEntity>? recentRecords,
  }) {
    return AttendanceSummaryEntity(
      totalSessions: totalSessions ?? this.totalSessions,
      present: present ?? this.present,
      absent: absent ?? this.absent,
      late: late ?? this.late,
      excused: excused ?? this.excused,
      online: online ?? this.online,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      punctualityRate: punctualityRate ?? this.punctualityRate,
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      recentRecords: recentRecords ?? this.recentRecords,
    );
  }
}
