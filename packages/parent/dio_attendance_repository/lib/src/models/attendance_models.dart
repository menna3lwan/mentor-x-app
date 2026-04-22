import 'package:mentorx_core/mentorx_core.dart';

final class AttendanceRecordModel extends AttendanceRecordEntity {
  const AttendanceRecordModel({
    required super.id,
    required super.status,
    required super.date,
    super.courseId,
    super.courseName,
    super.sessionTitle,
    super.checkInMethod,
    super.checkInTime,
    super.teacherNotes,
    super.centerName,
    super.startTime,
    super.endTime,
    super.isOnline = false,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id']?.toString() ?? '',
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'absent'),
        orElse: () => AttendanceStatus.absent,
      ),
      date: json['date'] != null
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : DateTime.now(),
      courseId: json['course_id']?.toString(),
      courseName: json['course_name'],
      sessionTitle: json['session_title'],
      checkInMethod: CheckInMethod.values.firstWhere(
        (e) => e.name == (json['check_in_method'] ?? 'manual'),
        orElse: () => CheckInMethod.manual,
      ),
      checkInTime: json['check_in_time'] != null
          ? DateTime.tryParse(json['check_in_time'])
          : null,
      teacherNotes: json['teacher_notes'],
      centerName: json['center_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      isOnline: json['is_online'] ?? false,
    );
  }
}

final class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({
    required super.totalSessions,
    required super.present,
    required super.late,
    required super.absent,
    required super.excused,
    super.online = 0,
    required super.attendanceRate,
    super.punctualityRate = 0.0,
    super.periodFrom,
    super.periodTo,
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      totalSessions: (json['total_sessions'] ?? 0).toInt(),
      present: (json['present'] ?? 0).toInt(),
      late: (json['late'] ?? 0).toInt(),
      absent: (json['absent'] ?? 0).toInt(),
      excused: (json['excused'] ?? 0).toInt(),
      online: (json['online'] ?? 0).toInt(),
      attendanceRate: (json['attendance_rate'] ?? 0.0).toDouble(),
      punctualityRate: (json['punctuality_rate'] ?? 0.0).toDouble(),
      periodFrom: json['period_from'] != null
          ? DateTime.tryParse(json['period_from'])
          : null,
      periodTo: json['period_to'] != null
          ? DateTime.tryParse(json['period_to'])
          : null,
    );
  }
}
