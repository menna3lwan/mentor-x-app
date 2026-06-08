import 'package:mentorx_core/mentorx_core.dart';

import 'models/attendance_group_models.dart';

export 'models/attendance_group_models.dart';

/// Dio-backed implementation of [ParentAttendanceGroupsRepository].
final class DioParentAttendanceGroupsRepository
    extends HttpClientRepository<ParentAttendanceGroupsRepositoryExceptionCode>
    implements ParentAttendanceGroupsRepository {
  final HttpClient _httpClient;

  DioParentAttendanceGroupsRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAttendanceGroupsRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentAttendanceGroupsRepositoryException(
    code: code,
    message: message,
  );

  @override
  Future<List<ParentAttendanceGroupEntity>> getGroups(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/attendance/parent/students/$childId/groups',
      );

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items
          .map(asMap)
          .map(ParentAttendanceGroupModel.fromJson)
          .toList(growable: false);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <ParentAttendanceGroupEntity>[];
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAttendanceGroupsRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  @override
  Future<ParentAttendanceGroupDetailEntity> getGroup({
    required String childId,
    required String groupId,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/attendance/parent/students/$childId/groups/$groupId',
      );

      final root = asMap(response.data);
      final payload = root['data'] is Map ? asMap(root['data']) : root;
      return ParentAttendanceGroupDetailModel.fromJson(payload);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) {
        throw const ParentAttendanceGroupsRepositoryException(
          code: ParentAttendanceGroupsRepositoryExceptionCode.notFound,
        );
      }
      if (e.statusCode == 405) {
        return ParentAttendanceGroupDetailEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAttendanceGroupsRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  ParentAttendanceGroupsRepositoryExceptionCode _classifyStatus(
    int statusCode,
  ) {
    return switch (statusCode) {
      401 ||
      403 => ParentAttendanceGroupsRepositoryExceptionCode.unauthorized,
      404 => ParentAttendanceGroupsRepositoryExceptionCode.notFound,
      _ => ParentAttendanceGroupsRepositoryExceptionCode.unknown,
    };
  }
}
