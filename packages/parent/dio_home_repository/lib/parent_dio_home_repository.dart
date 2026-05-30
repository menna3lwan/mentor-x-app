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
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/summary',
        queryParameters: {'student_id': studentId},
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
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/recent-activity',
        queryParameters: {
          'student_id': studentId,
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
