import 'package:mentorx_core/mentorx_core.dart';

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
    final String sourceStr = ModelParser.asString(json['source']).toUpperCase();

    return AttendanceRecordModel(
      id: ModelParser.asString(json['id']),
      status: _parseStatus(json['type'] ?? json['status']),
      date:
          ModelParser.asDateTime(json['attendedAt'] ?? json['date']) ??
          DateTime.now(),
      studentId: ModelParser.asString(json['studentId']),
      studentName: ModelParser.asString(json['studentName']),
      studentCode: ModelParser.asString(json['studentCode']),
      weekId: ModelParser.asString(json['weekId']),
      weekTitle: ModelParser.asString(json['weekTitle']),
      source: _parseSource(json['source']),
      scannedBy: ModelParser.asString(json['scannedBy']),
      notes: ModelParser.asString(json['notes']),
      checkInTime: ModelParser.asDateTime(json['attendedAt']),
      isOnline: sourceStr == 'ONLINE',
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'present' || str == 'attended') return AttendanceStatus.present;
    if (str == 'late') return AttendanceStatus.late;
    if (str == 'excused') return AttendanceStatus.excused;
    return AttendanceStatus.absent;
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

final class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({
    required super.totalSessions,
    required super.present,
    required super.late,
    required super.absent,
    required super.excused,
    super.online,
    required super.attendanceRate,
    super.punctualityRate,
    super.periodFrom,
    super.periodTo,
    super.recentRecords,
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      totalSessions: ModelParser.asInt(
        json['total_sessions'] ?? json['totalSessions'],
      ),
      present: ModelParser.asInt(json['present']),
      late: ModelParser.asInt(json['late']),
      absent: ModelParser.asInt(json['absent']),
      excused: ModelParser.asInt(json['excused']),
      online: ModelParser.asInt(json['online']),
      attendanceRate: ModelParser.asDouble(
        json['attendance_rate'] ?? json['attendanceRate'],
      ),
      punctualityRate: ModelParser.asDouble(
        json['punctuality_rate'] ?? json['punctualityRate'],
      ),
      periodFrom: ModelParser.asDateTime(
        json['period_from'] ?? json['periodFrom'],
      ),
      periodTo: ModelParser.asDateTime(json['period_to'] ?? json['periodTo']),
      recentRecords:
          ModelParser.asList(json['recent_records'] ?? json['recentRecords'])
              .map((e) => AttendanceRecordModel.fromJson(ModelParser.asMap(e)))
              .toList(),
    );
  }
}
