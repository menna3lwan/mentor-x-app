part of 'package:mentorx_core/mentorx_core.dart';

enum ParentAnalyticsRepositoryExceptionCode {
  unknown,
  failedToLoadGradeComparison,
  failedToLoadCourseProgress,
  failedToLoadActiveHours,
  failedToLoadAchievements,
  failedToLoadStreak,
  failedToLoadQuizSpeed,
}

final class ParentAnalyticsRepositoryException
    extends MentorXException<ParentAnalyticsRepositoryExceptionCode> {
  const ParentAnalyticsRepositoryException({required super.code, super.message});
}

abstract interface class ParentAnalyticsRepository {
  Future<void> initialize();

  /// Fetch grade comparison for a child.
  Future<List<PerformanceSnapshotEntity>> getChildGradeComparison(
    String childId, {
    String? courseId,
  });

  /// Fetch course progress for a child.
  Future<List<PerformanceSnapshotEntity>> getChildCourseProgress(
    String childId,
  );

  /// Fetch active hours heatmap for a child.
  Future<List<ActivityHeatmapEntity>> getChildActiveHours(String childId);

  /// Fetch achievements for a child.
  Future<List<AchievementEntity>> getChildAchievements(String childId);

  /// Fetch activity streak for a child.
  Future<StreakEntity> getChildStreak(String childId);

  /// Fetch quiz speed metrics for a child.
  Future<List<QuizSpeedMetricEntity>> getChildQuizSpeed(
    String childId, {
    String? courseId,
  });
}
