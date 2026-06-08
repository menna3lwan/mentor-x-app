part of 'package:mentorx_core/mentorx_core.dart';

/// A scheduled weekly session for an attendance group.
class ParentGroupScheduleEntry extends Equatable {
  /// 1 (Monday) .. 7 (Sunday) — matches Dart's [DateTime.weekday].
  final int dayOfWeek;

  /// `HH:mm` 24-hour wall clock time. Stored as a string because the
  /// backend formats it that way and converting to a typed `TimeOfDay`
  /// would force us to invent a timezone.
  final String startTime;
  final String endTime;
  final String? room;

  const ParentGroupScheduleEntry({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.room,
  });

  @override
  List<Object?> get props => [dayOfWeek, startTime, endTime, room];
}

/// Lightweight row used in the groups list.
class ParentAttendanceGroupEntity extends Equatable {
  final String id;
  final String name;
  final String? courseName;
  final String? teacherName;
  final int enrolledCount;
  final List<ParentGroupScheduleEntry> schedule;
  final bool isActive;

  const ParentAttendanceGroupEntity({
    required this.id,
    required this.name,
    this.courseName,
    this.teacherName,
    this.enrolledCount = 0,
    this.schedule = const [],
    this.isActive = true,
  });

  static const placeholder = ParentAttendanceGroupEntity(id: '', name: '');

  @override
  List<Object?> get props => [
    id,
    name,
    courseName,
    teacherName,
    enrolledCount,
    schedule,
    isActive,
  ];
}

/// One session record inside a group — attended / absent / late etc.
class ParentGroupSessionEntity extends Equatable {
  final String id;
  final DateTime date;
  final String? topic;
  final AttendanceStatus status;
  final String? note;

  const ParentGroupSessionEntity({
    required this.id,
    required this.date,
    required this.status,
    this.topic,
    this.note,
  });

  @override
  List<Object?> get props => [id, date, topic, status, note];
}

/// Full detail for a single group — includes schedule, recent sessions and
/// per-child attendance summary.
class ParentAttendanceGroupDetailEntity extends Equatable {
  final ParentAttendanceGroupEntity group;
  final String? description;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<ParentGroupSessionEntity> recentSessions;
  final int totalSessions;
  final int attendedSessions;
  final int missedSessions;
  final int lateSessions;

  const ParentAttendanceGroupDetailEntity({
    required this.group,
    this.description,
    this.location,
    this.startDate,
    this.endDate,
    this.recentSessions = const [],
    this.totalSessions = 0,
    this.attendedSessions = 0,
    this.missedSessions = 0,
    this.lateSessions = 0,
  });

  double get attendanceRatio {
    if (totalSessions <= 0) return 0;
    return (attendedSessions / totalSessions).clamp(0.0, 1.0);
  }

  static const empty = ParentAttendanceGroupDetailEntity(
    group: ParentAttendanceGroupEntity.placeholder,
  );

  @override
  List<Object?> get props => [
    group,
    description,
    location,
    startDate,
    endDate,
    recentSessions,
    totalSessions,
    attendedSessions,
    missedSessions,
    lateSessions,
  ];
}
