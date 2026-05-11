part of 'package:mentorx_core/mentorx_core.dart';

enum StudentAnalyticsRepositoryExceptionCode {
  unknown,
  failedToLoadSummary,
  failedToLoadPerformanceTimeline,
  failedToLoadActivityHeatmap,
  failedToLoadAchievements,
  failedToLoadStreak,
  failedToLoadQuizSpeedMetrics,
}

final class StudentAnalyticsRepositoryException
    extends MentorXException<StudentAnalyticsRepositoryExceptionCode> {
  const StudentAnalyticsRepositoryException({required super.code, super.message});
}

abstract interface class StudentAnalyticsRepository {
  Future<void> initialize();

  /// Fetch aggregated summary for the analytics dashboard.
  Future<StudentAnalyticsSummaryEntity> getDashboardSummary();

  /// Fetch performance data points over time.
  Future<List<PerformanceSnapshotEntity>> getPerformanceTimeline({String? courseId});

  /// Fetch student activity patterns.
  Future<List<ActivityHeatmapEntity>> getActivityHeatmap();

  /// Fetch student achievements/badges.
  Future<List<AchievementEntity>> getAchievements();

  /// Fetch platform activity streak.
  Future<StreakEntity> getStreak();

  /// Fetch speed metrics for completed quizzes.
  Future<List<QuizSpeedMetricEntity>> getQuizSpeedMetrics({String? courseId});
}
