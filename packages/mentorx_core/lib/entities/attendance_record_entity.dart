part of '../mentorx_core.dart';

enum AttendanceStatus { present, late, absent, excused, online }

enum CheckInMethod { qrCode, manual, auto }

final class AttendanceRecordEntity extends Equatable {
  final String id;
  final String? courseId;
  final String? courseName;
  final String? sessionTitle;
  final AttendanceStatus status;
  final CheckInMethod? checkInMethod;
  final DateTime? checkInTime;
  final DateTime date;
  final String? teacherNotes;

  const AttendanceRecordEntity({
    required this.id,
    required this.status,
    required this.date,
    this.courseId,
    this.courseName,
    this.sessionTitle,
    this.checkInMethod,
    this.checkInTime,
    this.teacherNotes,
  });

  @override
  List<Object?> get props => [
        id,
        courseId,
        courseName,
        sessionTitle,
        status,
        checkInMethod,
        checkInTime,
        date,
        teacherNotes,
      ];
}
