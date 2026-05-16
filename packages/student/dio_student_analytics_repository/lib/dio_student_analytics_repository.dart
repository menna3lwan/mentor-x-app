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
  }) => throw StudentAnalyticsRepositoryException(code: code, message: message);

  @override
  Future<StudentAnalyticsSummaryEntity> getDashboardSummary() async {
    try {
      final gradeComparisonResponse = await httpClient.get(
        '/api/analytics/student/grade-comparison',
      );
      final gradeData = gradeComparisonResponse.asMap();

      final heatmap = await getActivityHeatmap();
      final achievements = await getAchievements();
      final streak = await getStreak();
      final speedMetrics = await getQuizSpeedMetrics();

      return StudentAnalyticsSummaryEntity(
        rank: ModelParser.asInt(gradeData['myRank']),
        totalStudents: ModelParser.asInt(gradeData['totalStudents']),
        studentAverage: ModelParser.asDouble(gradeData['myAvgPercentage']),
        classAverage: ModelParser.asDouble(gradeData['classAvgPercentage']),
        performanceTimeline:
            const [], // Backend doesn't provide a true timeline yet
        activityHeatmap: heatmap,
        achievements: achievements,
        streak: streak,
        quizSpeedMetrics: speedMetrics,
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentAnalyticsRepositoryExceptionCode.failedToLoadSummary,
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
        '/api/analytics/student/course-progress',
      );

      final list = response.asList();
      // Map ProgressSummaryDto to PerformanceSnapshotEntity
      return list.map((e) {
        final map = asMap(e);
        return PerformanceSnapshotModel(
          label: ModelParser.asString(map['courseTitle']),
          studentScore: ModelParser.asDouble(map['progress']),
          averageScore: ModelParser.asDouble(map['avgQuizScore']),
          date: ModelParser.asDateTime(map['lastAccessedAt']) ?? DateTime.now(),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentAnalyticsRepositoryExceptionCode
            .failedToLoadPerformanceTimeline,
      );
    }
  }

  @override
  Future<List<ActivityHeatmapEntity>> getActivityHeatmap() async {
    try {
      final response = await httpClient.get(
        '/api/analytics/student/active-hours',
      );
      final list = response.asList();

      return list.map((e) {
        final map = asMap(e);
        final hour = ModelParser.asInt(map['hour']);
        return ActivityHeatmapEntity(
          dayOfWeek: 0, // Backend doesn't provide day yet, just aggregate hours
          hourOfDay: hour,
          intensity: ModelParser.asInt(map['count']),
        );
      }).toList();
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
      final response = await httpClient.get(
        '/api/analytics/student/achievements',
      );
      final data = response.asMap();

      final unlocked = asList(
        data['unlocked'],
      ).map((e) => _mapAchievement(asMap(e), true));
      final locked = asList(
        data['locked'],
      ).map((e) => _mapAchievement(asMap(e), false));

      return [...unlocked, ...locked];
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            StudentAnalyticsRepositoryExceptionCode.failedToLoadAchievements,
      );
    }
  }

  AchievementEntity _mapAchievement(Map<String, dynamic> map, bool unlocked) {
    return AchievementEntity(
      id: ModelParser.asString(map['id']),
      title: ModelParser.asString(map['title']),
      description: ModelParser.asString(map['description']),
      iconUrl: ModelParser.asString(map['icon']),
      isUnlocked: unlocked,
    );
  }

  @override
  Future<StreakEntity> getStreak() async {
    try {
      final response = await httpClient.get('/api/analytics/student/streak');
      final data = response.asMap();

      return StreakEntity(
        currentStreak: ModelParser.asInt(data['currentStreakDays']),
        longestStreak: ModelParser.asInt(data['longestStreakDays']),
        lastActivityAt: ModelParser.asDateTime(data['lastActivityDate']),
      );
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
      );

      final list = response.asList();
      return list.map((e) {
        final map = asMap(e);
        final timeSpentSeconds = ModelParser.asInt(map['durationSeconds']);
        final questionCount = ModelParser.asInt(map['questionCount']);
        return QuizSpeedMetricEntity(
          quizId: ModelParser.asString(map['quizId']),
          quizTitle: ModelParser.asString(map['quizTitle']),
          score: ModelParser.asInt(map['score']),
          timeSpentSeconds: timeSpentSeconds,
          questionCount: questionCount,
          averageSecondsPerQuestion: questionCount > 0
              ? timeSpentSeconds / questionCount
              : 0,
          submittedAt:
              ModelParser.asDateTime(map['submittedAt']) ?? DateTime.now(),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentAnalyticsRepositoryExceptionCode
            .failedToLoadQuizSpeedMetrics,
      );
    }
  }
}
