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
    // Matches AttendanceResponse schema
    final String typeStr = ModelParser.asString(json['type']).toUpperCase();
    final String sourceStr = ModelParser.asString(json['source']).toUpperCase();
    
    return AttendanceRecordModel(
      id: ModelParser.asString(json['id']),
      status: _parseStatus(json['status'] ?? 'present'), // Default to present if record exists
      date: ModelParser.asDateTime(json['attendedAt'] ?? json['date']) ?? DateTime.now(),
      courseId: ModelParser.asString(json['weekId'] ?? json['id']),
      courseName: ModelParser.asString(json['weekTitle'] ?? json['title']),
      sessionTitle: ModelParser.asString(json['notes'] ?? json['sessionTitle']),
      checkInMethod: _parseMethod(sourceStr),
      checkInTime: ModelParser.asDateTime(json['attendedAt']),
      teacherNotes: ModelParser.asString(json['notes'] ?? json['scannedBy']),
      centerName: ModelParser.asString(json['centerName']),
      startTime: ModelParser.asString(json['startTime']),
      endTime: ModelParser.asString(json['endTime']),
      isOnline: typeStr == 'ONLINE',
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'present' || str == 'attended' || str == 'attended_at') return AttendanceStatus.present;
    if (str == 'late') return AttendanceStatus.late;
    if (str == 'excused') return AttendanceStatus.excused;
    return AttendanceStatus.absent;
  }

  static CheckInMethod _parseMethod(String source) {
    if (source == 'QR_SCAN') return CheckInMethod.qr;
    if (source == 'ONLINE_ACCESS') return CheckInMethod.manual; // Map online to manual for now
    return CheckInMethod.manual;
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
      totalSessions: ModelParser.asInt(json['total_sessions'] ?? json['totalSessions']),
      present: ModelParser.asInt(json['present']),
      late: ModelParser.asInt(json['late']),
      absent: ModelParser.asInt(json['absent']),
      excused: ModelParser.asInt(json['excused']),
      online: ModelParser.asInt(json['online']),
      attendanceRate: ModelParser.asDouble(json['attendance_rate'] ?? json['attendanceRate']),
      punctualityRate: ModelParser.asDouble(json['punctuality_rate'] ?? json['punctualityRate']),
      periodFrom: ModelParser.asDateTime(json['period_from'] ?? json['periodFrom']),
      periodTo: ModelParser.asDateTime(json['period_to'] ?? json['periodTo']),
      recentRecords: ModelParser.asList(json['recent_records'] ?? json['recentRecords'])
          .map((e) => AttendanceRecordModel.fromJson(ModelParser.asMap(e)))
          .toList(),
    );
  }
}
