part of '../mentorx_core.dart';

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
    int page = 1,
    int limit = 20,
  });

  /// Check in via QR code scan.
  Future<AttendanceRecordEntity> checkIn(String qrData);
}
