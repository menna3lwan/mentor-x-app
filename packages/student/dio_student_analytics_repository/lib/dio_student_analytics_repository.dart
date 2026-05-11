import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_http_client/dio_http_client.dart';

class DioStudentAnalyticsRepository implements StudentAnalyticsRepository {
  DioStudentAnalyticsRepository({required DioHttpClient client});

  @override
  Future<void> initialize() async {}

  @override
  Future<StudentAnalyticsSummaryEntity> getDashboardSummary() async {
    // In a real implementation, this might call a single dashboard endpoint 
    // or aggregate from multiple. For now, we aggregate some and mock others.
    
    final timeline = await getPerformanceTimeline();
    final heatmap = await getActivityHeatmap();
    final achievements = await getAchievements();
    final streak = await getStreak();
    final speedMetrics = await getQuizSpeedMetrics();

    return StudentAnalyticsSummaryEntity(
      rank: 12, // Mocked until leaderboard aggregation is stable
      totalStudents: 450,
      studentAverage: 88.5,
      classAverage: 78.2,
      performanceTimeline: timeline,
      activityHeatmap: heatmap,
      achievements: achievements,
      streak: streak,
      quizSpeedMetrics: speedMetrics,
    );
  }

  @override
  Future<List<PerformanceSnapshotEntity>> getPerformanceTimeline({String? courseId}) async {
    // Mocking for now to provide the "pro UI" experience
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

  @override
  Future<List<ActivityHeatmapEntity>> getActivityHeatmap() async {
    // Mocking activity heatmap data
    final List<ActivityHeatmapEntity> data = [];
    for (int day = 1; day <= 7; day++) {
      for (int hour = 0; hour < 24; hour++) {
        // High intensity in evenings (18-22)
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
        id: '3',
        title: 'بطل الاختبارات',
        description: 'حل 10 اختبارات في أسبوع واحد',
        iconUrl: 'assets/icons/badges/quiz_master.png',
        isUnlocked: true,
      ),
      const AchievementEntity(
        id: '4',
        title: 'سريع البديهة',
        description: 'حل اختبار كامل في نصف الوقت المحدد',
        iconUrl: 'assets/icons/badges/fast_thinker.png',
        isUnlocked: false,
      ),
      const AchievementEntity(
        id: '5',
        title: 'منضبط المواعيد',
        description: 'تسليم 5 واجبات قبل الموعد النهائي بـ 24 ساعة',
        iconUrl: 'assets/icons/badges/punctual.png',
        isUnlocked: false,
      ),
    ];
  }

  @override
  Future<StreakEntity> getStreak() async {
    return StreakEntity(
      currentStreak: 15,
      longestStreak: 22,
      lastActivityAt: DateTime.now(),
    );
  }

  @override
  Future<List<QuizSpeedMetricEntity>> getQuizSpeedMetrics({String? courseId}) async {
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
