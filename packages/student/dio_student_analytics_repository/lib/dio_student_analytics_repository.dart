import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';
import 'models/analytics_models.dart';

final class DioStudentAnalyticsRepository
    extends HttpClientRepository<StudentAnalyticsRepositoryExceptionCode>
    implements StudentAnalyticsRepository {
  final HttpClient httpClient;

  DioStudentAnalyticsRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    StudentAnalyticsRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw StudentAnalyticsRepositoryException(code: code, message: message);

  @override
  Future<StudentAnalyticsSummaryEntity> getDashboardSummary() async {
    try {
      final timeline = await getPerformanceTimeline();
      final heatmap = await getActivityHeatmap();
      final achievements = await getAchievements();
      final streak = await getStreak();
      final speedMetrics = await getQuizSpeedMetrics();

      return StudentAnalyticsSummaryEntity(
        rank: 0, // Should be fetched from a summary endpoint if available
        totalStudents: 0,
        studentAverage: 0,
        classAverage: 0,
        performanceTimeline: timeline,
        activityHeatmap: heatmap,
        achievements: achievements,
        streak: streak,
        quizSpeedMetrics: speedMetrics,
      );
    } catch (e) {
      return throwException(
        StudentAnalyticsRepositoryExceptionCode.failedToLoadSummary,
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<PerformanceSnapshotEntity>> getPerformanceTimeline({
    String? courseId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/student/grade-comparison',
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
            StudentAnalyticsRepositoryExceptionCode.failedToLoadPerformanceTimeline,
      );
    }
  }

  @override
  Future<List<ActivityHeatmapEntity>> getActivityHeatmap() async {
    try {
      final response = await httpClient.get('/api/analytics/student/active-hours');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => ActivityHeatmapModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentAnalyticsRepositoryExceptionCode.failedToLoadActivityHeatmap,
      );
    }
  }

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    try {
      final response = await httpClient.get('/api/analytics/student/achievements');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => AchievementModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentAnalyticsRepositoryExceptionCode.failedToLoadAchievements,
      );
    }
  }

  @override
  Future<StreakEntity> getStreak() async {
    try {
      final response = await httpClient.get('/api/analytics/student/streak');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return StreakModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentAnalyticsRepositoryExceptionCode.failedToLoadStreak,
      );
    }
  }

  @override
  Future<List<QuizSpeedMetricEntity>> getQuizSpeedMetrics({
    String? courseId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/analytics/student/quiz-speed',
        queryParameters: {if (courseId != null) 'course_id': courseId},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => QuizSpeedMetricModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentAnalyticsRepositoryExceptionCode.failedToLoadQuizSpeedMetrics,
      );
    }
  }
}
