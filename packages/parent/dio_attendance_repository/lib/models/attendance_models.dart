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
    // Backend (Swagger AttendanceResponse):
    //   { id, studentId, studentName, studentCode, weekId, weekTitle,
    //     attendedAt, type, source, scannedBy, notes }
    return AttendanceRecordModel(
      id: ModelParser.asString(json['id']),
      // Backend sends `type` (present/late/absent); legacy sends `status`.
      status: AttendanceStatus.values.firstWhere(
        (e) =>
            e.name ==
            ModelParser.asString(
              json['status'] ?? json['type'],
              fallback: 'absent',
            ),
        orElse: () => AttendanceStatus.absent,
      ),
      // Backend sends `attendedAt`; legacy sends `date`.
      date:
          ModelParser.asDateTime(
            json['attendedAt'] ?? json['attended_at'] ?? json['date'],
          ) ??
          DateTime.now(),
      courseId: ModelParser.asString(
        json['course_id'] ?? json['courseId'] ?? json['weekId'],
      ),
      courseName: ModelParser.asString(
        json['course_name'] ?? json['courseName'],
      ),
      // Backend sends `weekTitle`; legacy sends `sessionTitle`.
      sessionTitle: ModelParser.asString(
        json['weekTitle'] ??
            json['week_title'] ??
            json['session_title'] ??
            json['sessionTitle'],
      ),
      // Backend sends `source`; legacy sends `checkInMethod`.
      checkInMethod: CheckInMethod.values.firstWhere(
        (e) =>
            e.name ==
            ModelParser.asString(
              json['source'] ??
                  json['check_in_method'] ??
                  json['checkInMethod'],
              fallback: 'manual',
            ),
        orElse: () => CheckInMethod.manual,
      ),
      checkInTime: ModelParser.asDateTime(
        json['check_in_time'] ?? json['checkInTime'] ?? json['attendedAt'],
      ),
      // Backend sends `notes`; legacy sends `teacherNotes`.
      teacherNotes: ModelParser.asString(
        json['notes'] ?? json['teacher_notes'] ?? json['teacherNotes'],
      ),
      centerName: ModelParser.asString(
        json['center_name'] ?? json['centerName'],
      ),
      startTime: ModelParser.asString(json['start_time'] ?? json['startTime']),
      endTime: ModelParser.asString(json['end_time'] ?? json['endTime']),
      isOnline: ModelParser.asBool(json['is_online'] ?? json['isOnline']),
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
    // Backend (Swagger ChildOverview):
    //   { totalAttendance, centerAttendance, onlineAttendance, ... }
    // Legacy format uses present/late/absent/excused/attendanceRate.
    final total = ModelParser.asInt(
      json['totalAttendance'] ??
          json['total_attendance'] ??
          json['total_sessions'] ??
          json['totalSessions'],
    );
    final online = ModelParser.asInt(
      json['onlineAttendance'] ?? json['online_attendance'] ?? json['online'],
    );

    return AttendanceSummaryModel(
      totalSessions: total,
      present: ModelParser.asInt(json['present']),
      late: ModelParser.asInt(json['late']),
      absent: ModelParser.asInt(json['absent']),
      excused: ModelParser.asInt(json['excused']),
      online: online,
      attendanceRate: ModelParser.asDouble(
        json['attendance_rate'] ?? json['attendanceRate'],
      ),
      punctualityRate: ModelParser.asDouble(
        json['punctuality_rate'] ?? json['punctualityRate'],
      ),
      periodFrom: ModelParser.asDateTime(
        json['period_from'] ?? json['periodFrom'],
      ),
      periodTo: ModelParser.asDateTime(
        json['period_to'] ?? json['periodTo'],
      ),
    );
  }
}
