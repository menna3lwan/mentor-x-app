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
  }) =>
      throw ParentAttendanceRepositoryException(code: code, message: message);

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
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      final data = asMap(response.data)['data'] ?? asList(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => AttendanceRecordModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
      final response = await _httpClient.get(
        '/api/parent/dashboard/child/$childId/overview',
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AttendanceSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAttendanceRepositoryExceptionCode.fetchError,
      );
    }
  }
}
