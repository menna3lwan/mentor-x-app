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
    // Backend doesn't have a summary endpoint, we derive from records or return empty
    return AttendanceSummaryEntity.placeholder;
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
    // Student app doesn't 'checkIn' via QR anymore, Teacher scans Student's QR.
    // However, if qrData is a weekId, we use online attendance.
    try {
      final response = await httpClient.post(
        '/api/attendance/online/$qrData',
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
  Future<AttendanceRecordEntity> scanCenterQr({
    required String qrToken,
    required String weekId,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/attendance/scan',
        data: {
          'qrToken': qrToken,
          'weekId': weekId,
        },
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
  Future<AttendanceRecordEntity?> getLessonAttendance(String weekId) async {
    try {
      final response = await httpClient.get('/api/attendance/lesson/$weekId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      if (data.isEmpty) return null;
      return AttendanceRecordModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.failedToLoadRecords,
      );
    }
  }

  @override
  Future<List<GroupEntity>> getMyGroups() async {
    try {
      final response = await httpClient.get('/api/attendance/student/groups');
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
        defaultCode: AttendanceRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getGroupBrief(String groupId) async {
    try {
      final response = await httpClient.get(
        '/api/attendance/student/groups/$groupId',
      );
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AttendanceRepositoryExceptionCode.unknown,
      );
    }
  }
}
