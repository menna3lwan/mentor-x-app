part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentAttendanceRepositoryExceptionCode {
  unknown,
  fetchError,
}

final class ParentAttendanceRepositoryException
    extends MentorXException<ParentAttendanceRepositoryExceptionCode> {
  const ParentAttendanceRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentAttendanceRepository {
  Future<List<AttendanceRecordEntity>> getAttendance(
    String childId, {
    DateTime? from,
    DateTime? to,
  });
  Future<AttendanceSummaryEntity> getAttendanceSummary(
    String childId, {
    DateTime? from,
    DateTime? to,
  });
}
