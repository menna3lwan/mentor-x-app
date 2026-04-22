import 'package:mentorx_core/mentorx_core.dart';
import 'models/home_models.dart';

final class DioHomeRepository
    extends HttpClientRepository<StudentHomeRepositoryExceptionCode>
    implements StudentHomeRepository {
  @override
  Never throwException(StudentHomeRepositoryExceptionCode code,
          {String? message}) =>
      throw StudentHomeRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioHomeRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<WalletSummaryEntity> getWalletSummary() async {
    try {
      final response = await httpClient.get('/api/student/wallet/summary');
      final data = _asMap(response.data)['data'] ?? _asMap(response.data);
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
      final data = _asMap(response.data)['data'] ?? _asMap(response.data);
      return _toInt(data['count']);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadUnreadNotificationsCount,
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

      final list = _asList(response.data);
      return list
          .map(_asMap)
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

      return _asList(response.data).map(_asMap).map(CourseModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: StudentHomeRepositoryExceptionCode.failedToLoadContinueLearning,
      );
    }
  }

  @override
  Future<List<CourseSummaryEntity>> getFeaturedCourses({String? gradeId}) async {
    try {
      final response = await httpClient.get(
        '/api/courses',
        queryParameters: {
          'featured': true,
          if (gradeId != null) 'grade_id': gradeId,
          'limit': 6,
        },
      );

      return _asList(response.data).map(_asMap).map(CourseModel.fromJson).toList();
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

      return _asList(response.data)
          .map(_asMap)
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

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map<String, dynamic>) {
      final data = value['data'] ?? value['items'];
      if (data is List<dynamic>) return data;
    }
    return <dynamic>[];
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
