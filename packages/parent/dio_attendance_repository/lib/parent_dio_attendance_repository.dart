import 'package:mentorx_core/mentorx_core.dart';
import 'models/attendance_models.dart';
export 'models/attendance_models.dart';

final class DioParentAttendanceRepository
    extends HttpClientRepository<ParentAttendanceRepositoryExceptionCode>
    implements ParentAttendanceRepository {
  final HttpClient httpClient;

  DioParentAttendanceRepository({required this.httpClient});

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
  }) async {
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/attendance',
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      final data = asList(response.data);
      return data.map((e) => AttendanceRecordModel.fromJson(asMap(e))).toList();
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
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/attendance/summary',
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
