part of '../../mock_data.dart';

final class MockAnalyticsGenerator {
  MockAnalyticsGenerator._();

  static List<PerformanceSnapshotEntity> performanceTimeline() {
    return [
      PerformanceSnapshotEntity(
        label: 'Sep',
        studentScore: 65,
        averageScore: 70,
        date: DateTime(2025, 9, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Oct',
        studentScore: 72,
        averageScore: 71,
        date: DateTime(2025, 10, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Nov',
        studentScore: 70,
        averageScore: 72,
        date: DateTime(2025, 11, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Dec',
        studentScore: 78,
        averageScore: 73,
        date: DateTime(2025, 12, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Jan',
        studentScore: 82,
        averageScore: 74,
        date: DateTime(2026, 1, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Feb',
        studentScore: 85,
        averageScore: 75,
        date: DateTime(2026, 2, 1),
      ),
      PerformanceSnapshotEntity(
        label: 'Mar',
        studentScore: 88,
        averageScore: 76,
        date: DateTime(2026, 3, 1),
      ),
    ];
  }

  static List<ActivityHeatmapEntity> activityHeatmap() {
    final List<ActivityHeatmapEntity> data = [];
    for (int day = 1; day <= 7; day++) {
      for (int hour = 0; hour < 24; hour++) {
        int intensity = 0;
        if (hour >= 18 && hour <= 22) {
          intensity = 3;
        } else if (hour >= 14 && hour <= 17) {
          intensity = 1;
        } else if (hour >= 8 && hour <= 12) {
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

  static List<AchievementEntity> achievements() {
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
        id: '3',
        title: 'بطل الاختبارات',
        description: 'حل 10 اختبارات في أسبوع واحد',
        iconUrl: 'assets/icons/badges/quiz_master.png',
        isUnlocked: true,
      ),
    ];
  }

  static StreakEntity streak() {
    return StreakEntity(
      currentStreak: 15,
      longestStreak: 22,
      lastActivityAt: DateTime.now(),
    );
  }

  static List<QuizSpeedMetricEntity> quizSpeedMetrics() {
    return [
      const QuizSpeedMetricEntity(
        quizId: 'q1',
        quizTitle: 'اختبار الحركة الموجية',
        timeSpentSeconds: 600,
        questionCount: 20,
        secondsPerQuestion: 30,
        averageSecondsPerQuestion: 45,
      ),
      const QuizSpeedMetricEntity(
        quizId: 'q2',
        quizTitle: 'اختبار الصوت',
        timeSpentSeconds: 450,
        questionCount: 15,
        secondsPerQuestion: 30,
        averageSecondsPerQuestion: 40,
      ),
    ];
  }
}
