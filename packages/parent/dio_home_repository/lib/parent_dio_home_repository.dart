import 'package:mentorx_core/mentorx_core.dart';
import 'models/announcement_model.dart';
import 'models/home_models.dart';
export 'models/announcement_model.dart';
export 'models/home_models.dart';

final class DioParentHomeRepository
    extends HttpClientRepository<ParentHomeRepositoryExceptionCode>
    implements ParentHomeRepository {
  final HttpClient _httpClient;

  DioParentHomeRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentHomeRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentHomeRepositoryException(code: code, message: message);

  @override
  Future<ParentHomeSummaryEntity> getSummary(String studentId) async {
    // Backend contract (Swagger): GET /api/parent/dashboard/summary
    // Returns the parent's dashboard with all children. No query parameters.
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/summary',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentHomeSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentHomeRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<ParentRecentActivityEntity>> getRecentActivity(
    String studentId, {
    int limit = 10,
    int page = 1,
  }) async {
    // API-CONTRACT (KNOWN MISMATCH):
    // /api/parent/dashboard/recent-activity is NOT declared in the EduCore
    // Postman collection. We probe it once and silently return an empty
    // list on 404/405 so the dashboard does not surface an error banner
    // for a non-existent backend endpoint. Coordinate with backend before
    // wiring this section to a real source.
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/recent-activity',
        queryParameters: {
          'student_id': studentId,
          'studentId': studentId,
          'limit': limit,
          'page': page,
        },
      );

      final data = asMap(response.data)['data'] ?? asList(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((json) => ParentRecentActivityModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <ParentRecentActivityEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentHomeRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(
    String studentId, {
    int limit = 3,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/announcements/active',
        queryParameters: {
          'student_id': studentId,
          'limit': limit,
        },
      );

      final data = asMap(response.data)['data'] ?? asList(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((json) => AnnouncementModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentHomeRepositoryExceptionCode.fetchError,
      );
    }
  }
}
