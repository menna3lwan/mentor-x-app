part of '../../mock_data.dart';

final class MockAttendanceGenerator {
  MockAttendanceGenerator._();

  static AttendanceSummaryEntity summary() {
    return const AttendanceSummaryEntity(
      totalSessions: 45,
      present: 35,
      late: 4,
      absent: 3,
      excused: 2,
      attendanceRate: 0.867,
    );
  }

  static List<AttendanceRecordEntity> records() {
    final now = DateTime.now();
    return [
      AttendanceRecordEntity(
        id: 'ar1',
        courseId: 'ep1',
        courseName: 'Advanced Algebra',
        sessionTitle: 'Linear Equations',
        status: AttendanceStatus.present,
        checkInMethod: CheckInMethod.qr,
        checkInTime: now.subtract(const Duration(hours: 2)),
        date: now,
      ),
      AttendanceRecordEntity(
        id: 'ar2',
        courseId: 'ep2',
        courseName: 'Physics Mechanics',
        sessionTitle: "Newton's Laws",
        status: AttendanceStatus.late,
        checkInMethod: CheckInMethod.manual,
        checkInTime: now.subtract(const Duration(days: 1, hours: 1)),
        date: now.subtract(const Duration(days: 1)),
      ),
      AttendanceRecordEntity(
        id: 'ar3',
        courseId: 'ep1',
        courseName: 'Advanced Algebra',
        sessionTitle: 'Quadratic Equations',
        status: AttendanceStatus.present,
        checkInMethod: CheckInMethod.qr,
        checkInTime: now.subtract(const Duration(days: 2, hours: 3)),
        date: now.subtract(const Duration(days: 2)),
      ),
      AttendanceRecordEntity(
        id: 'ar4',
        courseId: 'ep3',
        courseName: 'English Grammar',
        sessionTitle: 'Tenses Review',
        status: AttendanceStatus.absent,
        date: now.subtract(const Duration(days: 3)),
      ),
      AttendanceRecordEntity(
        id: 'ar5',
        courseId: 'ep2',
        courseName: 'Physics Mechanics',
        sessionTitle: 'Energy Conservation',
        status: AttendanceStatus.excused,
        date: now.subtract(const Duration(days: 5)),
        teacherNotes: 'Medical excuse provided',
      ),
      AttendanceRecordEntity(
        id: 'ar6',
        courseId: 'ep1',
        courseName: 'Advanced Algebra',
        sessionTitle: 'Polynomials',
        status: AttendanceStatus.present,
        checkInMethod: CheckInMethod.qr,
        checkInTime: now.subtract(const Duration(days: 7, hours: 2)),
        date: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  static AttendanceRecordEntity checkInResult(String qrData) {
    return AttendanceRecordEntity(
      id: 'ar_new',
      courseId: 'ep1',
      courseName: 'Advanced Algebra',
      sessionTitle: "Today's Session",
      status: AttendanceStatus.present,
      checkInMethod: CheckInMethod.qr,
      checkInTime: DateTime.now(),
      date: DateTime.now(),
    );
  }
}
