import 'package:mentorx_core/mentorx_core.dart';
import 'models/attendance_models.dart';
export 'models/attendance_models.dart';

final class DioParentAttendanceRepository
    extends HttpClientRepository<ParentAttendanceRepositoryExceptionCode>
    implements ParentAttendanceRepository {
  final HttpClient httpClient;

  DioParentAttendanceRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAttendanceRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentAttendanceRepositoryException(code: code, message: message);
  }

  @override
  Future<List<AttendanceRecordEntity>> getAttendance(
    String childId, {
    DateTime? from,
    DateTime? to,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/attendance',
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final list = response.asList();
      return list.map((e) => AttendanceRecordModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<AttendanceSummaryEntity> getAttendanceSummary(
    String childId, {
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/overview',
      );

      final data = response.asMap();
      // Backend returns ChildOverview, we map what we can to summary
      return AttendanceSummaryModel(
        totalSessions: ModelParser.asInt(data['totalAttendance']),
        present: ModelParser.asInt(data['totalAttendance']),
        late: 0,
        absent: 0,
        excused: 0,
        attendanceRate: 100.0,
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<GroupEntity>> getChildGroups(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/attendance/parent/students/$childId/groups',
      );

      final list = response.asList();

      return list.map((e) {
        final map = asMap(e);
        return GroupEntity(
          id: asString(map['groupId'] ?? map['id']),
          name: asString(map['groupTitle'] ?? map['groupName'] ?? map['name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getGroupBrief(
    String childId,
    String groupId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/attendance/parent/students/$childId/groups/$groupId',
      );
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
      );
    }
  }
}
