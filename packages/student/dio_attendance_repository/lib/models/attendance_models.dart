import 'package:mentorx_core/mentorx_core.dart';

final class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({
    required super.totalSessions,
    required super.present,
    required super.absent,
    required super.late,
    required super.excused,
    required super.attendanceRate,
    super.online = 0,
    super.punctualityRate = 0.0,
    super.periodFrom,
    super.periodTo,
    super.recentRecords = const [],
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      totalSessions: _toInt(json['totalSessions'] ?? json['total_sessions']),
      present: _toInt(json['present'] ?? json['total_present'] ?? json['present_count']),
      absent: _toInt(json['absent'] ?? json['total_absent'] ?? json['absent_count']),
      late: _toInt(json['late'] ?? json['total_late'] ?? json['late_count']),
      excused: _toInt(json['excused'] ?? json['total_excused'] ?? json['excused_count']),
      online: _toInt(json['online'] ?? json['total_online'] ?? json['online_count']),
      attendanceRate: _toDouble(json['attendanceRate'] ?? json['attendance_rate']),
      punctualityRate: _toDouble(json['punctualityRate'] ?? json['punctuality_rate']),
      periodFrom: json['periodFrom'] != null ? DateTime.tryParse(json['periodFrom']) : (json['period_from'] != null ? DateTime.tryParse(json['period_from']) : null),
      periodTo: json['periodTo'] != null ? DateTime.tryParse(json['periodTo']) : (json['period_to'] != null ? DateTime.tryParse(json['period_to']) : null),
      recentRecords: (json['recentRecords'] as List? ?? json['recent_records'] as List? ?? [])
          .map((e) => AttendanceRecordModel.fromJson(e))
          .toList(),
    );
  }
}

final class AttendanceRecordModel extends AttendanceRecordEntity {
  const AttendanceRecordModel({
    required super.id,
    required super.status,
    required super.date,
    super.studentId,
    super.courseId,
    super.courseName,
    super.sessionId,
    super.sessionTitle,
    super.checkInMethod,
    super.checkInTime,
    super.notes,
    super.teacherNotes,
    super.centerName,
    super.startTime,
    super.endTime,
    super.isOnline = false,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id']?.toString() ?? '',
      status: _parseStatus(json['status']),
      date: DateTime.tryParse(json['date'] ?? json['created_at'] ?? '') ?? DateTime.now(),
      studentId: json['student_id']?.toString() ?? json['studentId']?.toString(),
      courseId: json['course_id']?.toString() ?? json['courseId']?.toString(),
      courseName: json['course_name']?.toString() ?? json['courseName']?.toString(),
      sessionId: json['session_id']?.toString() ?? json['sessionId']?.toString(),
      sessionTitle: json['session_title']?.toString() ?? json['sessionTitle']?.toString(),
      checkInMethod: _parseMethod(json['check_in_method'] ?? json['checkInMethod']),
      checkInTime: json['check_in_time'] != null ? DateTime.tryParse(json['check_in_time']) : (json['checkInTime'] != null ? DateTime.tryParse(json['checkInTime']) : null),
      notes: json['notes']?.toString(),
      teacherNotes: json['teacher_notes']?.toString() ?? json['teacherNotes']?.toString(),
      centerName: json['center_name']?.toString() ?? json['centerName']?.toString(),
      startTime: json['start_time']?.toString() ?? json['startTime']?.toString(),
      endTime: json['end_time']?.toString() ?? json['endTime']?.toString(),
      isOnline: json['is_online'] ?? json['isOnline'] ?? false,
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    if (value == null) return AttendanceStatus.absent;
    final str = value.toString().toLowerCase();
    return AttendanceStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => AttendanceStatus.absent,
    );
  }

  static CheckInMethod? _parseMethod(dynamic value) {
    if (value == null) return null;
    final str = value.toString().toLowerCase();
    return CheckInMethod.values.firstWhere(
      (e) => e.name == str,
      orElse: () => CheckInMethod.manual,
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
