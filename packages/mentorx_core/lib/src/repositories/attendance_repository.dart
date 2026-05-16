part of 'package:mentorx_core/mentorx_core.dart';

enum AttendanceRepositoryExceptionCode {
  unknown,
  failedToLoadSummary,
  failedToLoadRecords,
  failedToCheckIn,
}

final class AttendanceRepositoryException
    extends MentorXException<AttendanceRepositoryExceptionCode> {
  AttendanceRepositoryException({required super.code, super.message});
}

abstract interface class AttendanceRepository {
  Future<void> initialize();

  /// Fetch attendance summary statistics for a date range.
  Future<AttendanceSummaryEntity> getSummary({
    DateTime? from,
    DateTime? to,
  });

  /// Fetch detailed attendance records with filters and pagination.
  Future<List<AttendanceRecordEntity>> getRecords({
    DateTime? from,
    DateTime? to,
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Check in via QR code scan.
  Future<AttendanceRecordEntity> checkIn(String qrData);

  /// Scan a center QR code to record attendance.
  Future<AttendanceRecordEntity> scanCenterQr({
    required String qrToken,
    required String weekId,
  });

  /// Fetch attendance for a specific lesson/week.
  Future<AttendanceRecordEntity?> getLessonAttendance(String weekId);

  /// Fetch student's attendance groups.
  Future<List<GroupEntity>> getMyGroups();

  /// Fetch detailed brief for a specific group.
  Future<Map<String, dynamic>> getGroupBrief(String groupId);
}
