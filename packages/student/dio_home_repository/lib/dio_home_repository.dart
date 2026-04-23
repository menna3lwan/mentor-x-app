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
      final response = await httpClient.get('/api/student/wallet/summary');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
      return intOrNull(data['count']) ?? 0;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentHomeRepositoryExceptionCode.failedToLoadUnreadNotificationsCount,
      );
    }
  }

  @override
  Future<List<BannerEntity>> getHomeBanners({String? gradeId}) async {
    try {
      final response = await httpClient.get(
        '/api/banners',
        queryParameters: {
          'placement': 'home',
          if (gradeId != null) 'grade_id': gradeId,
        },
      );

      final list = asList(response.data);
      return list
          .map(asMap)
          .map(BannerModel.fromJson)
          .where((banner) => banner.id.isNotEmpty && banner.imageUrl.isNotEmpty)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadBanners,
      );
    }
  }

  @override
  Future<List<CourseSummaryEntity>> getContinueLearningCourses() async {
    try {
      final response = await httpClient.get(
        '/api/student/courses',
        queryParameters: {
          'status': 'in_progress',
          'sort': 'last_accessed',
          'limit': 5,
        },
      );

      return asList(response.data)
          .map(asMap)
          .map(CourseModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
      final response = await httpClient.get(
        '/api/courses',
        queryParameters: {
          'featured': true,
          if (gradeId != null) 'grade_id': gradeId,
          'limit': 6,
        },
      );

      return asList(response.data)
          .map(asMap)
          .map(CourseModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadFeaturedCourses,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getRecentAnnouncements() async {
    try {
      final response = await httpClient.get(
        '/api/announcements',
        queryParameters: {'limit': 3},
      );

      return asList(response.data)
          .map(asMap)
          .map(AnnouncementModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
}
