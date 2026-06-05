import 'package:mentorx_core/mentorx_core.dart';

import 'models/analytics_models.dart';

export 'models/analytics_models.dart';

/// Dio-backed implementation of [ParentAnalyticsRepository].
///
/// EduCore endpoints (all GET, all wrapped in `{success, data, error}`):
/// - `/api/analytics/parent/child/{id}/grade-comparison`
/// - `/api/analytics/parent/child/{id}/course-progress`
/// - `/api/analytics/parent/child/{id}/active-hours`
/// - `/api/analytics/parent/child/{id}/achievements`
/// - `/api/analytics/parent/child/{id}/streak`
/// - `/api/analytics/parent/child/{id}/quiz-speed`
///
/// Each call tolerates either the envelope or a raw payload, and degrades
/// gracefully (returns `empty` entity) on 404 / 405 so a missing-on-backend
/// analytics surface doesn't break the dashboard.
final class DioParentAnalyticsRepository
    extends HttpClientRepository<ParentAnalyticsRepositoryExceptionCode>
    implements ParentAnalyticsRepository {
  final HttpClient _httpClient;

  DioParentAnalyticsRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAnalyticsRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentAnalyticsRepositoryException(code: code, message: message);

  @override
  Future<ParentChildGradeComparisonEntity> getGradeComparison(
    String childId,
  ) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/grade-comparison',
      );
      return ParentChildGradeComparisonModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentChildGradeComparisonEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadGradeComparison,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<ParentChildCourseProgressEntity> getCourseProgress(
    String childId,
  ) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/course-progress',
      );
      return ParentChildCourseProgressModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentChildCourseProgressEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadCourseProgress,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<ParentChildActiveHoursEntity> getActiveHours(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/active-hours',
      );
      return ParentChildActiveHoursModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentChildActiveHoursEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadActiveHours,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<ParentChildAchievementsEntity> getAchievements(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/achievements',
      );
      return ParentChildAchievementsModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentChildAchievementsEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadAchievements,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<StreakEntity> getStreak(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/streak',
      );
      return ParentChildStreakModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const StreakEntity(currentStreak: 0, longestStreak: 0);
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAnalyticsRepositoryExceptionCode.failedToLoadStreak,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<ParentChildQuizSpeedEntity> getQuizSpeed(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/analytics/parent/child/$childId/quiz-speed',
      );
      return ParentChildQuizSpeedModel.fromJson(_extract(response.data));
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentChildQuizSpeedEntity.empty;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadQuizSpeed,
        codeFromStatusCode: _classify,
      );
    }
  }

  // ─────────────────────────── Helpers ─────────────────────────────────────

  Map<String, dynamic> _extract(dynamic raw) {
    final root = asMap(raw);
    if (root['data'] is Map) return asMap(root['data']);
    return root;
  }

  ParentAnalyticsRepositoryExceptionCode _classify(int statusCode) {
    return switch (statusCode) {
      401 || 403 => ParentAnalyticsRepositoryExceptionCode.unauthorized,
      404 => ParentAnalyticsRepositoryExceptionCode.notFound,
      _ => ParentAnalyticsRepositoryExceptionCode.unknown,
    };
  }
}
