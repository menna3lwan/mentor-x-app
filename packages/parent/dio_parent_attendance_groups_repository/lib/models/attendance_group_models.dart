import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────
// Schedule entry
// ─────────────────────────────────────────────────────────────────────────

final class ParentGroupScheduleEntryModel extends ParentGroupScheduleEntry {
  const ParentGroupScheduleEntryModel({
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    super.room,
  });

  factory ParentGroupScheduleEntryModel.fromJson(Map<String, dynamic> json) {
    return ParentGroupScheduleEntryModel(
      dayOfWeek: _parseDayOfWeek(
        json['dayOfWeek'] ?? json['day_of_week'] ?? json['day'],
      ),
      startTime: ModelParser.asString(
        json['startTime'] ?? json['start_time'] ?? json['from'],
      ),
      endTime: ModelParser.asString(
        json['endTime'] ?? json['end_time'] ?? json['to'],
      ),
      room: _stringOrNull(json['room'] ?? json['location']),
    );
  }

  static int _parseDayOfWeek(dynamic value) {
    if (value == null) return 1;
    if (value is num) return value.toInt().clamp(1, 7);
    final str = value.toString().trim().toLowerCase();
    final asInt = int.tryParse(str);
    if (asInt != null) return asInt.clamp(1, 7);
    return switch (str) {
      'monday' || 'mon' => 1,
      'tuesday' || 'tue' => 2,
      'wednesday' || 'wed' => 3,
      'thursday' || 'thu' => 4,
      'friday' || 'fri' => 5,
      'saturday' || 'sat' => 6,
      'sunday' || 'sun' => 7,
      _ => 1,
    };
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Group list row
// ─────────────────────────────────────────────────────────────────────────

final class ParentAttendanceGroupModel extends ParentAttendanceGroupEntity {
  const ParentAttendanceGroupModel({
    required super.id,
    required super.name,
    super.courseName,
    super.teacherName,
    super.enrolledCount,
    super.schedule,
    super.isActive,
  });

  factory ParentAttendanceGroupModel.fromJson(Map<String, dynamic> json) {
    final scheduleList = ModelParser.asList(
      json['schedule'] ?? json['sessions'] ?? json['timetable'],
    );
    return ParentAttendanceGroupModel(
      id: ModelParser.asString(json['id'] ?? json['groupId'] ?? json['group_id']),
      name: ModelParser.asString(
        json['name'] ?? json['title'] ?? json['groupName'] ?? json['group_name'],
      ),
      courseName: _stringOrNull(
        json['courseName'] ?? json['course_name'] ?? json['subject'],
      ),
      teacherName: _stringOrNull(
        json['teacherName'] ??
            json['teacher_name'] ??
            json['instructor'] ??
            json['teacher'],
      ),
      enrolledCount: ModelParser.asInt(
        json['enrolledCount'] ??
            json['enrolled_count'] ??
            json['studentsCount'] ??
            json['students_count'],
      ),
      schedule: scheduleList
          .map(ModelParser.asMap)
          .map(ParentGroupScheduleEntryModel.fromJson)
          .toList(),
      isActive: ModelParser.asBool(
        json['isActive'] ?? json['is_active'] ?? json['active'],
        fallback: true,
      ),
    );
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Recent session row
// ─────────────────────────────────────────────────────────────────────────

final class ParentGroupSessionModel extends ParentGroupSessionEntity {
  const ParentGroupSessionModel({
    required super.id,
    required super.date,
    required super.status,
    super.topic,
    super.note,
  });

  factory ParentGroupSessionModel.fromJson(Map<String, dynamic> json) {
    return ParentGroupSessionModel(
      id: ModelParser.asString(json['id'] ?? json['sessionId']),
      date:
          ModelParser.asDateTime(json['date'] ?? json['sessionDate']) ??
          DateTime.now(),
      status: _parseStatus(json['status'] ?? json['attendanceStatus']),
      topic: _stringOrNull(json['topic'] ?? json['title']),
      note: _stringOrNull(json['note'] ?? json['comment']),
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

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Group detail
// ─────────────────────────────────────────────────────────────────────────

final class ParentAttendanceGroupDetailModel
    extends ParentAttendanceGroupDetailEntity {
  const ParentAttendanceGroupDetailModel({
    required super.group,
    super.description,
    super.location,
    super.startDate,
    super.endDate,
    super.recentSessions,
    super.totalSessions,
    super.attendedSessions,
    super.missedSessions,
    super.lateSessions,
  });

  factory ParentAttendanceGroupDetailModel.fromJson(
    Map<String, dynamic> json,
  ) {
    // Some backends nest the group, others flatten everything at root.
    final groupJson = json['group'] is Map
        ? Map<String, dynamic>.from(json['group'] as Map)
        : json;
    final group = ParentAttendanceGroupModel.fromJson(groupJson);

    final sessionsList = ModelParser.asList(
      json['recentSessions'] ??
          json['recent_sessions'] ??
          json['sessions'] ??
          json['history'],
    );

    return ParentAttendanceGroupDetailModel(
      group: group,
      description: _stringOrNull(
        json['description'] ?? json['summary'],
      ),
      location: _stringOrNull(json['location'] ?? json['address']),
      startDate: ModelParser.asDateTime(
        json['startDate'] ?? json['start_date'],
      ),
      endDate: ModelParser.asDateTime(json['endDate'] ?? json['end_date']),
      recentSessions: sessionsList
          .map(ModelParser.asMap)
          .map(ParentGroupSessionModel.fromJson)
          .toList(),
      totalSessions: ModelParser.asInt(
        json['totalSessions'] ?? json['total_sessions'],
      ),
      attendedSessions: ModelParser.asInt(
        json['attendedSessions'] ??
            json['attended_sessions'] ??
            json['present'],
      ),
      missedSessions: ModelParser.asInt(
        json['missedSessions'] ??
            json['missed_sessions'] ??
            json['absent'],
      ),
      lateSessions: ModelParser.asInt(
        json['lateSessions'] ?? json['late_sessions'] ?? json['late'],
      ),
    );
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }
}
