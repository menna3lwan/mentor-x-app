import 'package:mentorx_core/mentorx_core.dart';
import 'models/home_models.dart';
export 'models/home_models.dart';

final class DioStudentHomeRepository
    extends HttpClientRepository<StudentHomeRepositoryExceptionCode>
    implements StudentHomeRepository {
  @override
  Never throwException(StudentHomeRepositoryExceptionCode code,
          {String? message}) =>
      throw StudentHomeRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioStudentHomeRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<WalletSummaryEntity> getWalletSummary() async {
    try {
      final response = await httpClient.get('/api/payment/wallet/balance');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadWalletSummary,
      );
    }
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    try {
      final response = await httpClient.get('/api/notifications/unread-count');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return intOrNull(data['count'] ?? data['unreadCount']) ?? 0;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentHomeRepositoryExceptionCode.failedToLoadUnreadNotificationsCount,
      );
    }
  }

  @override
  Future<List<BannerEntity>> getHomeBanners({String? gradeId}) async {
    try {
      final queryParams = {
        'placement': 'home',
        if (gradeId != null) 'grade_id': gradeId,
      };

      final response = await httpClient.get(
        '/api/banners/active',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map(asMap)
          .map(BannerModel.fromJson)
          .where((banner) => banner.id.isNotEmpty && banner.imageUrl.isNotEmpty)
          .toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 403) return [];
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadBanners,
      );
    }
  }

  @override
  Future<List<CourseSummaryEntity>> getContinueLearningCourses() async {
    try {
      final queryParams = {
        'size': 5,
        'sort': 'lastAccessedAt,desc',
      };

      final response = await httpClient.get(
        '/api/enrollments/my-enrollments',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final content = asList(data is Map ? data['content'] : data);
      return content
          .map(asMap)
          .map(CourseModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentHomeRepositoryExceptionCode.failedToLoadContinueLearning,
      );
    }
  }

  @override
  Future<List<CourseSummaryEntity>> getFeaturedCourses(
      {String? gradeId}) async {
    try {
      final queryParams = {
        'featured': true,
        if (gradeId != null) 'grade_id': gradeId,
        'size': 6,
      };

      final response = await httpClient.get(
        '/api/courses',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final content = asList(data is Map ? data['content'] : data);
      return content
          .map(asMap)
          .map(CourseModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadFeaturedCourses,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getRecentAnnouncements() async {
    try {
      final queryParams = {'limit': 3};
      final response = await httpClient.get(
        '/api/announcements/active',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);

      return list
          .map(asMap)
          .map(AnnouncementModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadAnnouncements,
      );
    }
  }
  @override
  Future<void> trackBannerClick(String bannerId) async {
    try {
      await httpClient.post('/api/banners/$bannerId/click');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToTrackBannerClick,
      );
    }
  }

  @override
  Future<BannerEntity> createBanner(Map<String, dynamic> data) async {
    try {
      final response = await httpClient.post('/api/banners', data: data);
      final responseData = asMap(response.data)["content"] ?? asMap(response.data);
      return BannerModel.fromJson(responseData);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: StudentHomeRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> updateBanner(String bannerId, Map<String, dynamic> data) async {
    try {
      await httpClient.patch('/api/banners/$bannerId', data: data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: StudentHomeRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> deleteBanner(String bannerId) async {
    try {
      await httpClient.delete('/api/banners/$bannerId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: StudentHomeRepositoryExceptionCode.unknown);
    }
  }
}
