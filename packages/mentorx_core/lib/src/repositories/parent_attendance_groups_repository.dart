part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentAttendanceGroupsRepositoryExceptionCode {
  unknown,
  fetchError,
  notFound,
  unauthorized,
}

final class ParentAttendanceGroupsRepositoryException
    extends MentorXException<ParentAttendanceGroupsRepositoryExceptionCode> {
  const ParentAttendanceGroupsRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Backs the per-child attendance groups screens.
///
/// Backend contract (Postman):
/// - `GET /api/attendance/parent/students/{studentId}/groups`
/// - `GET /api/attendance/parent/students/{studentId}/groups/{groupId}`
///
/// The wire shape isn't documented in Postman, so the Dio implementation
/// defends against both snake/camel and envelope/raw payloads. Mock builds
/// can satisfy this interface without touching the network at all.
abstract interface class ParentAttendanceGroupsRepository {
  Future<void> initialize();

  /// Lists the attendance groups the [childId] is enrolled in.
  Future<List<ParentAttendanceGroupEntity>> getGroups(String childId);

  /// Fetches one group with its schedule, recent sessions and attendance
  /// summary for the [childId].
  Future<ParentAttendanceGroupDetailEntity> getGroup({
    required String childId,
    required String groupId,
  });
}
