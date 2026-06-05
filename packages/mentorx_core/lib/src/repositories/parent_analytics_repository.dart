part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentAnalyticsRepositoryExceptionCode {
  unknown,
  failedToLoadGradeComparison,
  failedToLoadCourseProgress,
  failedToLoadActiveHours,
  failedToLoadAchievements,
  failedToLoadStreak,
  failedToLoadQuizSpeed,
  unauthorized,
  notFound,
}

final class ParentAnalyticsRepositoryException
    extends MentorXException<ParentAnalyticsRepositoryExceptionCode> {
  const ParentAnalyticsRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Backs the Parent Analytics dashboard. Each method maps 1:1 to a backend
/// endpoint under `/api/analytics/parent/child/{studentId}/*`. The six
/// surfaces are independent — failure in one does not block the others.
abstract interface class ParentAnalyticsRepository {
  Future<void> initialize();

  Future<ParentChildGradeComparisonEntity> getGradeComparison(String childId);

  Future<ParentChildCourseProgressEntity> getCourseProgress(String childId);

  Future<ParentChildActiveHoursEntity> getActiveHours(String childId);

  Future<ParentChildAchievementsEntity> getAchievements(String childId);

  Future<StreakEntity> getStreak(String childId);

  Future<ParentChildQuizSpeedEntity> getQuizSpeed(String childId);
}
