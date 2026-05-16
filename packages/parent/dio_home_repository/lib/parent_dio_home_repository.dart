import 'package:mentorx_core/mentorx_core.dart';
import 'models/announcement_model.dart';
import 'models/home_models.dart';
export 'models/announcement_model.dart';
export 'models/home_models.dart';

final class DioParentHomeRepository
    extends HttpClientRepository<ParentHomeRepositoryExceptionCode>
    implements ParentHomeRepository {
  DioParentHomeRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

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
        '/api/parent/dashboard/summary',
      );

      final data = response.asMap();
      return ParentHomeSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentHomeRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<ParentChildDashboardSummaryEntity> getChildOverview(
    String studentId,
  ) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/dashboard/child/$studentId/overview',
      );

      final data = response.asMap();
      return ParentChildDashboardSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      final queryParams = {
        'student_id': studentId,
        'size': limit,
        'page': page - 1,
      };

      final response = await _httpClient.get(
        '/api/parent/dashboard/child/$studentId/attendance', // Using attendance as activity for now
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list
          .map((json) => ParentRecentActivityModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      final queryParams = {
        'student_id': studentId,
        'size': limit,
      };
      final response = await _httpClient.get(
        '/api/announcements/active',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list
          .map((json) => AnnouncementModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentHomeRepositoryExceptionCode.fetchError,
      );
    }
  }
}
