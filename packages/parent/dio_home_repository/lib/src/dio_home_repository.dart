import 'package:mentorx_core/mentorx_core.dart';
import '../models/announcement_model.dart';
import '../models/home_models.dart';


final class DioParentHomeRepository extends HttpClientRepository<ParentHomeRepositoryExceptionCode>
    implements ParentHomeRepository {
  DioParentHomeRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient;

  @override
  Never throwException(
    ParentHomeRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentHomeRepositoryException(code: code, message: message);

  final HttpClient _httpClient;

  @override
  Future<ParentHomeSummaryEntity> getSummary(String studentId) async {
    try {
      final response = await _httpClient.get(
        '/api/v1/parent/dashboard/summary',
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
        '/api/v1/parent/dashboard/recent-activity',
        queryParameters: {
          'student_id': studentId,
          'limit': limit,
          'page': page,
        },
      );
      final data = asList(response.data);
      return data
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
        '/api/v1/parent/dashboard/announcements',
        queryParameters: {
          'student_id': studentId,
          'limit': limit,
        },
      );
      final data = asList(response.data);
      return data
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
