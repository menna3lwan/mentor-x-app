import 'package:mentorx_core/mentorx_core.dart';
import 'models/attendance_models.dart';

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
    const defaultException = ParentAttendanceRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/attendance',
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => AttendanceRecordModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<AttendanceSummaryEntity> getAttendanceSummary(
    String childId, {
    DateTime? from,
    DateTime? to,
  }) async {
    const defaultException = ParentAttendanceRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/attendance/summary',
        queryParameters: {
          if (from != null) 'from': from.toIso8601String(),
          if (to != null) 'to': to.toIso8601String(),
        },
      );

      return AttendanceSummaryModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }
}
