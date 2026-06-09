import 'package:mentorx_core/mentorx_core.dart';
import 'models/attendance_models.dart';
export 'models/attendance_models.dart';

final class DioParentAttendanceRepository
    extends HttpClientRepository<ParentAttendanceRepositoryExceptionCode>
    implements ParentAttendanceRepository {
  final HttpClient _httpClient;

  DioParentAttendanceRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAttendanceRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentAttendanceRepositoryException(code: code, message: message);

  // Backend contract (Postman):
  //   GET /api/parent/dashboard/child/{studentId}/attendance
  //   GET /api/parent/dashboard/child/{studentId}/overview
  // Both wrap their payload in the standard {success, data, error} envelope.
  @override
  Future<List<AttendanceRecordEntity>> getAttendance(
    String childId, {
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/child/$childId/attendance',
        queryParameters: {
          'page': 0,
          'size': 20,
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final list = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return list.map((e) => AttendanceRecordModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classify,
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
      final response = await _httpClient.get(
        '/api/parent/dashboard/child/$childId/overview',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AttendanceSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classify,
      );
    }
  }

  ParentAttendanceRepositoryExceptionCode _classify(int statusCode) {
    return switch (statusCode) {
      401 || 403 => ParentAttendanceRepositoryExceptionCode.unauthorized,
      _ => ParentAttendanceRepositoryExceptionCode.fetchError,
    };
  }
}
