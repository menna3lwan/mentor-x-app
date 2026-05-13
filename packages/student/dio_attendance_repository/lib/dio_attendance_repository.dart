import 'package:mentorx_core/mentorx_core.dart';
import 'models/attendance_models.dart';
export 'models/attendance_models.dart';

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
    try {
      final queryParams = {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
      };

      final response = await httpClient.get(
        '/api/attendance/summary',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AttendanceSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.failedToLoadSummary,
      );
    }
  }

  @override
  Future<List<AttendanceRecordEntity>> getRecords({
    DateTime? from,
    DateTime? to,
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        if (courseId != null) 'course_id': courseId,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/attendance/my',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => AttendanceRecordModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.failedToLoadRecords,
      );
    }
  }

  @override
  Future<AttendanceRecordEntity> checkIn(String qrData) async {
    try {
      final response = await httpClient.post(
        '/api/attendance/check-in',
        data: {'qr_data': qrData},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AttendanceRecordModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.failedToCheckIn,
      );
    }
  }

  @override
  Future<List<GroupEntity>> getMyGroups() async {
    try {
      final response = await httpClient.get('/api/attendance/groups/student/my-groups');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      
      return list.map((e) {
        final map = asMap(e);
        return GroupEntity(
          id: asString(map['id']),
          name: asString(map['name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.unknown,
      );
    }
  }
}
