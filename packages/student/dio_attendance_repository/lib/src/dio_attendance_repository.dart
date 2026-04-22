import 'package:mentorx_core/mentorx_core.dart';
import '../models/attendance_models.dart';

final class DioAttendanceRepository
    extends HttpClientRepository<AttendanceRepositoryExceptionCode>
    implements AttendanceRepository {
  @override
  Never throwException(
    AttendanceRepositoryExceptionCode code, {
    String? message,
  }) => throw AttendanceRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAttendanceRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

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

    final data = _asMap(response.data['data'] ?? response.data);
    return AttendanceSummaryModel.fromJson(data);
  }

  @override
  Future<List<AttendanceRecordEntity>> getRecords({
    DateTime? from,
    DateTime? to,
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/attendance/records',
      queryParameters: {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        if (courseId != null) 'course_id': courseId,
        if (paginationInfo != null) ...paginationInfo.toJson(),
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

    return AttendanceRecordModel.fromJson(
      response.data['data'] ?? response.data,
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return <String, dynamic>{};
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
