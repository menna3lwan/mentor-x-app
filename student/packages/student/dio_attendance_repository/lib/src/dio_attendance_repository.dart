import 'package:mentorx_core/mentorx_core.dart';
import '../models/attendance_models.dart';

final class DioAttendanceRepository
    extends HttpClientRepository<AttendanceRepositoryExceptionCode>
    implements AttendanceRepository {
  @override
  Never throwException(AttendanceRepositoryExceptionCode code,
          {String? message}) =>
      throw AttendanceRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAttendanceRepository({required this.httpClient});

  @override
  Future<AttendanceSummaryEntity> getSummary({
    DateTime? from,
    DateTime? to,
  }) async {
    final response = await httpClient.get(
      '/api/attendance/summary',
      queryParameters: {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
      },
    );

    if (response.statusCode != 200) {
      throw AttendanceRepositoryException(
        code: AttendanceRepositoryExceptionCode.failedToLoadSummary,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    return AttendanceSummaryEntity(
      totalSessions: (data['totalSessions'] ?? data['total_sessions'] as num?)?.toInt() ?? 0,
      present: (data['present'] ?? data['total_present'] as num?)?.toInt() ?? 0,
      absent: (data['absent'] ?? data['total_absent'] as num?)?.toInt() ?? 0,
      late: (data['late'] ?? data['total_late'] as num?)?.toInt() ?? 0,
      excused: (data['excused'] ?? data['total_excused'] as num?)?.toInt() ?? 0,
      attendanceRate: (data['attendanceRate'] ?? data['attendance_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  Future<List<AttendanceRecordEntity>> getRecords({
    DateTime? from,
    DateTime? to,
    String? courseId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/attendance/records',
      queryParameters: {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        if (courseId != null) 'course_id': courseId,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw AttendanceRepositoryException(
        code: AttendanceRepositoryExceptionCode.failedToLoadRecords,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AttendanceRecordModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<AttendanceRecordEntity> checkIn(String qrData) async {
    final response = await httpClient.post(
      '/api/attendance/check-in',
      data: {'qr_data': qrData},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AttendanceRepositoryException(
        code: AttendanceRepositoryExceptionCode.failedToCheckIn,
        message: response.exception?.message,
      );
    }

    return AttendanceRecordModel.fromJson(response.data['data'] ?? response.data);
  }
}
