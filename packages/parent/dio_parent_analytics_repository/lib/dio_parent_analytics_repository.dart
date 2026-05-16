import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';
import 'models/analytics_models.dart';

final class DioParentAnalyticsRepository
    extends HttpClientRepository<ParentAnalyticsRepositoryExceptionCode>
    implements ParentAnalyticsRepository {
  final HttpClient httpClient;

  DioParentAnalyticsRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAnalyticsRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentAnalyticsRepositoryException(code: code, message: message);

  @override
  Future<List<PerformanceSnapshotEntity>> getChildGradeComparison(
    String childId, {
    String? courseId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/grade-comparison',
        queryParameters: {if (courseId != null) 'course_id': courseId},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => PerformanceSnapshotModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadGradeComparison,
      );
    }
  }

  @override
  Future<List<PerformanceSnapshotEntity>> getChildCourseProgress(
    String childId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/course-progress',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => PerformanceSnapshotModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadCourseProgress,
      );
    }
  }

  @override
  Future<List<ActivityHeatmapEntity>> getChildActiveHours(
    String childId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/active-hours',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => ActivityHeatmapModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadActiveHours,
      );
    }
  }

  @override
  Future<List<AchievementEntity>> getChildAchievements(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/achievements',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => AchievementModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadAchievements,
      );
    }
  }

  @override
  Future<StreakEntity> getChildStreak(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/streak',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return StreakModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAnalyticsRepositoryExceptionCode.failedToLoadStreak,
      );
    }
  }

  @override
  Future<List<QuizSpeedMetricEntity>> getChildQuizSpeed(
    String childId, {
    String? courseId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/parent/child/$childId/quiz-speed',
        queryParameters: {if (courseId != null) 'course_id': courseId},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => QuizSpeedMetricModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAnalyticsRepositoryExceptionCode.failedToLoadQuizSpeed,
      );
    }
  }
}
