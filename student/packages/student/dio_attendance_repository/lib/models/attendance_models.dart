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
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id']?.toString() ?? '',
      status: _parseStatus(json['status']),
      date: DateTime.parse((json['date'] ?? json['timestamp'] ?? json['created_at']) as String),
      courseId: (json['courseId'] ?? json['course_id'])?.toString(),
      courseName: json['courseName'] as String?,
      sessionTitle: (json['sessionTitle'] ?? json['session_title']) as String?,
      checkInMethod: _parseMethod(json['checkInMethod'] ?? json['check_in_method']),
      checkInTime: json['checkInTime'] != null ? DateTime.parse(json['checkInTime'] as String) : null,
      teacherNotes: (json['teacherNotes'] ?? json['notes']) as String?,
    );
  }

  static AttendanceStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return AttendanceStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => AttendanceStatus.present,
    );
  }

  static CheckInMethod _parseMethod(dynamic value) {
    if (value == null) return CheckInMethod.manual;
    final str = value.toString().toLowerCase();
    return CheckInMethod.values.firstWhere(
      (e) => e.name == str,
      orElse: () => CheckInMethod.manual,
    );
  }
}
