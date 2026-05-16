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
      totalSessions: ModelParser.asInt(
        json['totalSessions'] ?? json['total_sessions'],
      ),
      present: ModelParser.asInt(
        json['present'] ?? json['total_present'] ?? json['present_count'],
      ),
      absent: ModelParser.asInt(
        json['absent'] ?? json['total_absent'] ?? json['absent_count'],
      ),
      late: ModelParser.asInt(
        json['late'] ?? json['total_late'] ?? json['late_count'],
      ),
      excused: ModelParser.asInt(
        json['excused'] ?? json['total_excused'] ?? json['excused_count'],
      ),
      online: ModelParser.asInt(
        json['online'] ?? json['total_online'] ?? json['online_count'],
      ),
      attendanceRate: ModelParser.asDouble(
        json['attendanceRate'] ?? json['attendance_rate'],
      ),
      punctualityRate: ModelParser.asDouble(
        json['punctualityRate'] ?? json['punctuality_rate'],
      ),
      periodFrom: ModelParser.asDateTime(
        json['periodFrom'] ?? json['period_from'],
      ),
      periodTo: ModelParser.asDateTime(json['periodTo'] ?? json['period_to']),
      recentRecords:
          ModelParser.asList(json['recentRecords'] ?? json['recent_records'])
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
    super.studentName,
    super.studentCode,
    super.courseId,
    super.courseName,
    super.weekId,
    super.weekTitle,
    super.sessionId,
    super.sessionTitle,
    super.checkInMethod,
    super.checkInTime,
    super.source,
    super.scannedBy,
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
      status: _parseStatus(json['status'] ?? json['type']),
      date:
          ModelParser.asDateTime(
            json['attendedAt'] ?? json['date'] ?? json['created_at'],
          ) ??
          DateTime.now(),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(
        json['studentName'] ?? json['student_name'],
      ),
      studentCode: ModelParser.asString(
        json['studentCode'] ?? json['student_code'],
      ),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      courseName: ModelParser.asString(
        json['courseName'] ?? json['course_name'],
      ),
      weekId: ModelParser.asString(json['weekId'] ?? json['week_id']),
      weekTitle: ModelParser.asString(json['weekTitle'] ?? json['week_title']),
      sessionId: ModelParser.asString(json['sessionId'] ?? json['session_id']),
      sessionTitle: ModelParser.asString(
        json['sessionTitle'] ?? json['session_title'],
      ),
      checkInMethod: _parseMethod(
        json['checkInMethod'] ?? json['check_in_method'],
      ),
      checkInTime: ModelParser.asDateTime(
        json['checkInTime'] ?? json['check_in_time'],
      ),
      source: _parseSource(json['source']),
      scannedBy: ModelParser.asString(json['scannedBy'] ?? json['scanned_by']),
      notes: ModelParser.asString(json['notes']),
      teacherNotes: ModelParser.asString(
        json['teacherNotes'] ?? json['teacher_notes'],
      ),
      centerName: ModelParser.asString(
        json['centerName'] ?? json['center_name'],
      ),
      startTime: ModelParser.asString(json['startTime'] ?? json['start_time']),
      endTime: ModelParser.asString(json['endTime'] ?? json['end_time']),
      isOnline: ModelParser.asBool(json['isOnline'] ?? json['is_online']),
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    for (final status in AttendanceStatus.values) {
      if (status.name.toLowerCase() == str) return status;
    }
    return AttendanceStatus.absent;
  }

  static CheckInMethod? _parseMethod(dynamic value) {
    if (value == null) return null;
    final str = ModelParser.asString(value).toLowerCase();
    for (final method in CheckInMethod.values) {
      if (method.name.toLowerCase() == str) return method;
    }
    return CheckInMethod.manual;
  }

  static AttendanceSource? _parseSource(dynamic value) {
    if (value == null) return null;
    final str = ModelParser.asString(value).toLowerCase();
    for (final source in AttendanceSource.values) {
      if (source.name.toLowerCase() == str) return source;
    }
    return null;
  }
}
