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
    final response = await httpClient.get('/api/student/wallet/summary');
    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadWalletSummary,
        message: response.exception?.message,
      );
    }

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return WalletSummaryModel.fromJson(data);
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    final response = await httpClient.get('/api/notifications/unread-count');
    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode
            .failedToLoadUnreadNotificationsCount,
        message: response.exception?.message,
      );
    }

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return _toInt(data['count']);
  }

  @override
  Future<List<BannerEntity>> getHomeBanners({String? gradeId}) async {
    final response = await httpClient.get(
      '/api/banners',
      queryParameters: {
        'placement': 'home',
        if (gradeId != null) 'grade_id': gradeId,
      },
    );

    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadBanners,
        message: response.exception?.message,
      );
    }

    final list = _asList(response.data);
    return list
        .map(_asMap)
        .map(BannerModel.fromJson)
        .where((banner) => banner.id.isNotEmpty && banner.imageUrl.isNotEmpty)
        .toList();
  }

  @override
  Future<List<CourseSummaryEntity>> getContinueLearningCourses() async {
    final response = await httpClient.get(
      '/api/student/courses',
      queryParameters: {
        'status': 'in_progress',
        'sort': 'last_accessed',
        'limit': 5,
      },
    );

    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadContinueLearning,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map(_asMap).map(CourseModel.fromJson).toList();
  }

  @override
  Future<List<CourseSummaryEntity>> getFeaturedCourses(
      {String? gradeId}) async {
    final response = await httpClient.get(
      '/api/courses',
      queryParameters: {
        'featured': true,
        if (gradeId != null) 'grade_id': gradeId,
        'limit': 6,
      },
    );

    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadFeaturedCourses,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map(_asMap).map(CourseModel.fromJson).toList();
  }

  @override
  Future<List<AnnouncementEntity>> getRecentAnnouncements() async {
    final response = await httpClient.get(
      '/api/announcements',
      queryParameters: {'limit': 3},
    );

    if (response.statusCode != 200) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadAnnouncements,
        message: response.exception?.message,
      );
    }

    return _asList(response.data)
        .map(_asMap)
        .map(AnnouncementModel.fromJson)
        .toList();
  }

  @override
  Future<void> trackBannerClick(String bannerId) async {
    final response = await httpClient.post('/api/banners/$bannerId/click');
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToTrackBannerClick,
        message: response.exception?.message,
      );
    }
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return <String, dynamic>{};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map<String, dynamic>) {
      final data = value['data'];
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
