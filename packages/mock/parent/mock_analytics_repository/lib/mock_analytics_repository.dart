import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAnalyticsRepository implements ParentAnalyticsRepository {
  final Duration delay;

  MockAnalyticsRepository({this.delay = const Duration(milliseconds: 500)});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<PerformanceSnapshotEntity>> getChildGradeComparison(
    String childId, {
    String? courseId,
  }) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.performanceTimeline();
  }

  @override
  Future<List<PerformanceSnapshotEntity>> getChildCourseProgress(
    String childId,
  ) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.performanceTimeline();
  }

  @override
  Future<List<ActivityHeatmapEntity>> getChildActiveHours(String childId) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.activityHeatmap();
  }

  @override
  Future<List<AchievementEntity>> getChildAchievements(String childId) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.achievements();
  }

  @override
  Future<StreakEntity> getChildStreak(String childId) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.streak();
  }

  @override
  Future<List<QuizSpeedMetricEntity>> getChildQuizSpeed(
    String childId, {
    String? courseId,
  }) async {
    await Future.delayed(delay);
    return MockAnalyticsGenerator.quizSpeedMetrics();
  }
}
