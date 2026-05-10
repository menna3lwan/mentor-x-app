import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';

class MockStudentAnalyticsRepository implements StudentAnalyticsRepository {
  @override
  Future<void> initialize() async {}

  @override
  Future<StudentAnalyticsSummaryEntity> getDashboardSummary() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final timeline = await getPerformanceTimeline();
    final heatmap = await getActivityHeatmap();
    final achievements = await getAchievements();
    final streak = await getStreak();
    final speedMetrics = await getQuizSpeedMetrics();

    return StudentAnalyticsSummaryEntity(
      rank: 5,
      totalStudents: 120,
      studentAverage: 92.5,
      classAverage: 81.0,
      performanceTimeline: timeline,
      activityHeatmap: heatmap,
      achievements: achievements,
      streak: streak,
      quizSpeedMetrics: speedMetrics,
    );
  }

  @override
  Future<List<PerformanceSnapshotEntity>> getPerformanceTimeline({String? courseId}) async {
    return [
      PerformanceSnapshotEntity(
        label: 'Sep',
        studentScore: 70,
        averageScore: 75,
        date: DateTime(2025, 9, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Oct',
        studentScore: 75,
        averageScore: 76,
        date: DateTime(2025, 10, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Nov',
        studentScore: 80,
        averageScore: 77,
        date: DateTime(2025, 11, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Dec',
        studentScore: 85,
        averageScore: 78,
        date: DateTime(2025, 12, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Jan',
        studentScore: 88,
        averageScore: 79,
        date: DateTime(2026, 1, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Feb',
        studentScore: 92,
        averageScore: 80,
        date: DateTime(2026, 2, 1),
      ),
    ];
  }

  @override
  Future<List<ActivityHeatmapEntity>> getActivityHeatmap() async {
    final List<ActivityHeatmapEntity> data = [];
    for (int day = 1; day <= 7; day++) {
      for (int hour = 0; hour < 24; hour++) {
        int intensity = 0;
        if (hour >= 20 && hour <= 23) {
          intensity = 4;
        } else if (hour >= 15 && hour <= 19) {
          intensity = 2;
        }
        data.add(ActivityHeatmapEntity(
          dayOfWeek: day,
          hourOfDay: hour,
          intensity: intensity,
        ));
      }
    }
    return data;
  }

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    return [
      const AchievementEntity(
        id: '1',
        title: 'منفوق أكاديمي',
        description: 'الحصول على درجة أعلى من 90% في 3 اختبارات متتالية',
        iconUrl: 'assets/icons/badges/academic_star.png',
        isUnlocked: true,
      ),
      const AchievementEntity(
        id: '2',
        title: 'قارئ نهم',
        description: 'فتح جميع ملفات الـ PDF في كورس واحد',
        iconUrl: 'assets/icons/badges/book_worm.png',
        isUnlocked: true,
      ),
      const AchievementEntity(
        id: '4',
        title: 'سريع البديهة',
        description: 'حل اختبار كامل في نصف الوقت المحدد',
        iconUrl: 'assets/icons/badges/fast_thinker.png',
        isUnlocked: false,
      ),
    ];
  }

  @override
  Future<StreakEntity> getStreak() async {
    return StreakEntity(
      currentStreak: 25,
      longestStreak: 30,
      lastActivityAt: DateTime.now(),
    );
  }

  @override
  Future<List<QuizSpeedMetricEntity>> getQuizSpeedMetrics({String? courseId}) async {
    return [
      const QuizSpeedMetricEntity(
        quizId: 'q1',
        quizTitle: 'اختبار الحركة الموجية',
        timeSpentSeconds: 500,
        questionCount: 20,
        secondsPerQuestion: 25,
        averageSecondsPerQuestion: 45,
      ),
    ];
  }
}
