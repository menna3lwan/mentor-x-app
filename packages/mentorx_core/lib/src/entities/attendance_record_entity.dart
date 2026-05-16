part of 'package:mentorx_core/mentorx_core.dart';

enum AttendanceStatus { present, absent, late, excused }

enum CheckInMethod { manual, qr, nfc, biometric, online }

enum AttendanceSource { center, online }

class AttendanceRecordEntity extends Equatable {
  final String id;
  final AttendanceStatus status;
  final DateTime date;
  final String? studentId;
  final String? studentName;
  final String? studentCode;
  final String? courseId;
  final String? courseName;
  final String? weekId;
  final String? weekTitle;
  final String? sessionId;
  final String? sessionTitle;
  final CheckInMethod? checkInMethod;
  final DateTime? checkInTime;
  final AttendanceSource? source;
  final String? scannedBy;
  final String? notes;
  final String? teacherNotes;
  final String? centerName;
  final String? startTime;
  final String? endTime;
  final bool isOnline;

  const AttendanceRecordEntity({
    required this.id,
    required this.status,
    required this.date,
    this.studentId,
    this.studentName,
    this.studentCode,
    this.courseId,
    this.courseName,
    this.weekId,
    this.weekTitle,
    this.sessionId,
    this.sessionTitle,
    this.checkInMethod,
    this.checkInTime,
    this.source,
    this.scannedBy,
    this.notes,
    this.teacherNotes,
    this.centerName,
    this.startTime,
    this.endTime,
    this.isOnline = false,
  });

  static final placeholder = AttendanceRecordEntity(
    id: '',
    status: AttendanceStatus.absent,
    date: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        status,
        date,
        studentId,
        studentName,
        studentCode,
        courseId,
        courseName,
        weekId,
        weekTitle,
        sessionId,
        sessionTitle,
        checkInMethod,
        checkInTime,
        source,
        scannedBy,
        notes,
        teacherNotes,
        centerName,
        startTime,
        endTime,
        isOnline,
      ];

  AttendanceRecordEntity copyWith({
    String? id,
    AttendanceStatus? status,
    DateTime? date,
    String? studentId,
    String? studentName,
    String? studentCode,
    String? courseId,
    String? courseName,
    String? weekId,
    String? weekTitle,
    String? sessionId,
    String? sessionTitle,
    CheckInMethod? checkInMethod,
    DateTime? checkInTime,
    AttendanceSource? source,
    String? scannedBy,
    String? notes,
    String? teacherNotes,
    String? centerName,
    String? startTime,
    String? endTime,
    bool? isOnline,
  }) {
    return AttendanceRecordEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      date: date ?? this.date,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentCode: studentCode ?? this.studentCode,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      weekId: weekId ?? this.weekId,
      weekTitle: weekTitle ?? this.weekTitle,
      sessionId: sessionId ?? this.sessionId,
      sessionTitle: sessionTitle ?? this.sessionTitle,
      checkInMethod: checkInMethod ?? this.checkInMethod,
      checkInTime: checkInTime ?? this.checkInTime,
      source: source ?? this.source,
      scannedBy: scannedBy ?? this.scannedBy,
      notes: notes ?? this.notes,
      teacherNotes: teacherNotes ?? this.teacherNotes,
      centerName: centerName ?? this.centerName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
