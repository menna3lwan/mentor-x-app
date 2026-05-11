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
      totalSessions: ModelParser.asInt(json['totalSessions'] ?? json['total_sessions']),
      present: ModelParser.asInt(json['present'] ?? json['total_present'] ?? json['present_count']),
      absent: ModelParser.asInt(json['absent'] ?? json['total_absent'] ?? json['absent_count']),
      late: ModelParser.asInt(json['late'] ?? json['total_late'] ?? json['late_count']),
      excused: ModelParser.asInt(json['excused'] ?? json['total_excused'] ?? json['excused_count']),
      online: ModelParser.asInt(json['online'] ?? json['total_online'] ?? json['online_count']),
      attendanceRate: ModelParser.asDouble(json['attendanceRate'] ?? json['attendance_rate']),
      punctualityRate: ModelParser.asDouble(json['punctualityRate'] ?? json['punctuality_rate']),
      periodFrom: ModelParser.asDateTime(json['periodFrom'] ?? json['period_from']),
      periodTo: ModelParser.asDateTime(json['periodTo'] ?? json['period_to']),
      recentRecords: ModelParser.asList(json['recentRecords'] ?? json['recent_records'])
          .map((e) => AttendanceRecordModel.fromJson(ModelParser.asMap(e)))
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
      id: ModelParser.asString(json['id']),
      status: _parseStatus(json['status']),
      date: ModelParser.asDateTime(json['date'] ?? json['created_at']) ?? DateTime.now(),
      studentId: ModelParser.asString(json['student_id'] ?? json['studentId']),
      courseId: ModelParser.asString(json['course_id'] ?? json['courseId']),
      courseName: ModelParser.asString(json['course_name'] ?? json['courseName']),
      sessionId: ModelParser.asString(json['session_id'] ?? json['sessionId']),
      sessionTitle: ModelParser.asString(json['session_title'] ?? json['sessionTitle']),
      checkInMethod: _parseMethod(json['check_in_method'] ?? json['checkInMethod']),
      checkInTime: ModelParser.asDateTime(json['check_in_time'] ?? json['checkInTime']),
      notes: ModelParser.asString(json['notes']),
      teacherNotes: ModelParser.asString(json['teacher_notes'] ?? json['teacherNotes']),
      centerName: ModelParser.asString(json['center_name'] ?? json['centerName']),
      startTime: ModelParser.asString(json['start_time'] ?? json['startTime']),
      endTime: ModelParser.asString(json['end_time'] ?? json['endTime']),
      isOnline: ModelParser.asBool(json['is_online'] ?? json['isOnline']),
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return AttendanceStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => AttendanceStatus.absent,
    );
  }

  static CheckInMethod? _parseMethod(dynamic value) {
    if (value == null) return null;
    final str = ModelParser.asString(value).toLowerCase();
    return CheckInMethod.values.firstWhere(
      (e) => e.name == str,
      orElse: () => CheckInMethod.manual,
    );
  }
}
