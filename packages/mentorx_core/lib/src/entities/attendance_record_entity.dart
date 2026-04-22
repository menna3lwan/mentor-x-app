part of 'package:mentorx_core/mentorx_core.dart';

enum AttendanceStatus { present, absent, late, excused }

enum CheckInMethod { manual, qr, nfc, biometric }

base class AttendanceRecordEntity extends Equatable {
  final String id;
  final AttendanceStatus status;
  final DateTime date;
  final String? studentId;
  final String? courseId;
  final String? courseName;
  final String? sessionId;
  final String? sessionTitle;
  final CheckInMethod? checkInMethod;
  final DateTime? checkInTime;
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
    this.courseId,
    this.courseName,
    this.sessionId,
    this.sessionTitle,
    this.checkInMethod,
    this.checkInTime,
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
        courseId,
        courseName,
        sessionId,
        sessionTitle,
        checkInMethod,
        checkInTime,
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
    String? courseId,
    String? courseName,
    String? sessionId,
    String? sessionTitle,
    CheckInMethod? checkInMethod,
    DateTime? checkInTime,
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
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      sessionId: sessionId ?? this.sessionId,
      sessionTitle: sessionTitle ?? this.sessionTitle,
      checkInMethod: checkInMethod ?? this.checkInMethod,
      checkInTime: checkInTime ?? this.checkInTime,
      notes: notes ?? this.notes,
      teacherNotes: teacherNotes ?? this.teacherNotes,
      centerName: centerName ?? this.centerName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
