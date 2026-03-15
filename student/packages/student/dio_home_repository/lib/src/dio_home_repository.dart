import 'package:mentorx_core/mentorx_core.dart';

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
  Future<WalletSummaryEntity> getWalletSummary() async {
    final response = await httpClient.get('/api/v1/student/wallet/summary');
    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadWalletSummary,
        message: response.exception?.message,
      );
    }

    final json = _asMap(response.data);
    return WalletSummaryEntity(
      walletBalance: _toDouble(json['wallet_balance']),
      points: _toInt(json['total_points']),
    );
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    final response = await httpClient.get('/api/v1/notifications/unread-count');
    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode
            .failedToLoadUnreadNotificationsCount,
        message: response.exception?.message,
      );
    }

    final json = _asMap(response.data);
    return _toInt(json['count']);
  }

  @override
  Future<List<BannerEntity>> getHomeBanners({String? gradeId}) async {
    final response = await httpClient.get(
      '/api/v1/banners',
      queryParameters: {
        'placement': 'home',
        if (gradeId != null) 'grade_id': gradeId,
      },
    );

    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadBanners,
        message: response.exception?.message,
      );
    }

    return _asList(response.data)
        .map(_asMap)
        .map(
          (e) => BannerEntity(
            id: e['id']?.toString() ?? '',
            imageUrl: e['image_url']?.toString() ?? '',
            title: e['title']?.toString(),
            actionType: e['action_type']?.toString() ?? 'internal',
            actionValue: e['action_value']?.toString() ?? '',
          ),
        )
        .where((banner) => banner.id.isNotEmpty && banner.imageUrl.isNotEmpty)
        .toList();
  }

  @override
  Future<List<CourseSummaryEntity>> getContinueLearningCourses() async {
    final response = await httpClient.get(
      '/api/v1/student/courses',
      queryParameters: {
        'status': 'in_progress',
        'sort': 'last_accessed',
        'limit': 5,
      },
    );

    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadContinueLearning,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map(_asMap).map(_mapCourse).toList();
  }

  @override
  Future<List<CourseSummaryEntity>> getFeaturedCourses(
      {String? gradeId}) async {
    final response = await httpClient.get(
      '/api/v1/courses',
      queryParameters: {
        'featured': true,
        if (gradeId != null) 'grade_id': gradeId,
        'limit': 6,
      },
    );

    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadFeaturedCourses,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map(_asMap).map(_mapCourse).toList();
  }

  @override
  Future<List<AnnouncementEntity>> getRecentAnnouncements() async {
    final response = await httpClient.get(
      '/api/v1/announcements',
      queryParameters: {'limit': 3},
    );

    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToLoadAnnouncements,
        message: response.exception?.message,
      );
    }

    return _asList(response.data)
        .map(_asMap)
        .map(
          (e) => AnnouncementEntity(
            id: e['id']?.toString() ?? '',
            title: e['title']?.toString() ?? '',
            preview: e['preview']?.toString() ?? e['content']?.toString() ?? '',
            createdAt: DateTime.tryParse(e['created_at']?.toString() ?? '') ??
                DateTime.now(),
            isPinned: (e['is_pinned'] as bool?) ?? false,
          ),
        )
        .toList();
  }

  @override
  Future<void> trackBannerClick(String bannerId) async {
    final response = await httpClient.post('/api/v1/banners/$bannerId/click');
    if (!response.isOk) {
      throw StudentHomeRepositoryException(
        code: StudentHomeRepositoryExceptionCode.failedToTrackBannerClick,
        message: response.exception?.message,
      );
    }
  }

  CourseSummaryEntity _mapCourse(Map<String, dynamic> e) {
    return CourseSummaryEntity(
      id: e['id']?.toString() ?? '',
      title: e['title']?.toString() ?? '',
      thumbnailUrl: e['thumbnail_url']?.toString() ?? '',
      progressPercent: e['progress_percent'] == null
          ? null
          : _toDouble(e['progress_percent']),
      price: e['price'] == null ? null : _toDouble(e['price']),
      enrolledCount: _toInt(e['enrolled_count']),
    );
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

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
