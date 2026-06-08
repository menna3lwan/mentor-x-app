import 'dart:math';

import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock that returns plausible parent-analytics fixtures so the
/// dashboard can be developed offline.
final class MockParentAnalyticsRepository implements ParentAnalyticsRepository {
  final Duration delay;

  MockParentAnalyticsRepository({
    this.delay = const Duration(milliseconds: 600),
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentChildGradeComparisonEntity> getGradeComparison(
    String childId,
  ) async {
    await Future<void>.delayed(delay);
    return const ParentChildGradeComparisonEntity(
      childOverallAverage: 84.5,
      classOverallAverage: 76.2,
      rank: 4,
      totalStudents: 32,
      rows: [
        ParentGradeComparisonRow(
          label: 'Mathematics',
          childScore: 88,
          classAverage: 74,
        ),
        ParentGradeComparisonRow(
          label: 'Physics',
          childScore: 82,
          classAverage: 78,
        ),
        ParentGradeComparisonRow(
          label: 'Chemistry',
          childScore: 79,
          classAverage: 75,
        ),
        ParentGradeComparisonRow(
          label: 'Biology',
          childScore: 91,
          classAverage: 80,
        ),
      ],
    );
  }

  @override
  Future<ParentChildCourseProgressEntity> getCourseProgress(
    String childId,
  ) async {
    await Future<void>.delayed(delay);
    return const ParentChildCourseProgressEntity(
      overallPercent: 62,
      courses: [
        ParentCourseProgressRow(
          courseId: '1',
          courseName: 'الجبر والمعادلات',
          progressPercent: 72,
          sessionsTotal: 24,
          sessionsCompleted: 17,
        ),
        ParentCourseProgressRow(
          courseId: '2',
          courseName: 'الفيزياء الحديثة',
          progressPercent: 58,
          sessionsTotal: 20,
          sessionsCompleted: 12,
        ),
        ParentCourseProgressRow(
          courseId: '3',
          courseName: 'الكيمياء العضوية',
          progressPercent: 45,
          sessionsTotal: 18,
          sessionsCompleted: 8,
        ),
      ],
    );
  }

  @override
  Future<ParentChildActiveHoursEntity> getActiveHours(String childId) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    final rng = Random(childId.hashCode);
    final days = List.generate(14, (i) {
      final date = DateTime(now.year, now.month, now.day - (13 - i));
      // Weekends slightly lower, weekdays slightly higher.
      final base = date.weekday >= 6 ? 25 : 55;
      final minutes = base + rng.nextInt(40);
      return ParentActiveDayEntity(date: date, minutes: minutes);
    });
    final total = days.fold<int>(0, (sum, d) => sum + d.minutes);
    return ParentChildActiveHoursEntity(
      days: days,
      totalMinutes: total,
      averageMinutesPerDay: (total / days.length).round(),
    );
  }

  @override
  Future<ParentChildAchievementsEntity> getAchievements(String childId) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    final achievements = [
      AchievementEntity(
        id: 'first-quiz',
        title: 'First Quiz Complete',
        description: 'Finished your very first quiz.',
        iconUrl: '',
        isUnlocked: true,
        unlockedAt: now.subtract(const Duration(days: 30)),
      ),
      AchievementEntity(
        id: 'streak-7',
        title: '7-Day Streak',
        description: 'Studied 7 days in a row.',
        iconUrl: '',
        isUnlocked: true,
        unlockedAt: now.subtract(const Duration(days: 5)),
      ),
      const AchievementEntity(
        id: 'top-grade',
        title: 'Top Grade',
        description: 'Score 95%+ on any quiz.',
        iconUrl: '',
        isUnlocked: false,
      ),
      const AchievementEntity(
        id: 'all-rounder',
        title: 'All-Rounder',
        description: 'Complete a course in every subject.',
        iconUrl: '',
        isUnlocked: false,
      ),
    ];
    return ParentChildAchievementsEntity(
      achievements: achievements,
      totalUnlocked: achievements.where((a) => a.isUnlocked).length,
    );
  }

  @override
  Future<StreakEntity> getStreak(String childId) async {
    await Future<void>.delayed(delay);
    return StreakEntity(
      currentStreak: 5,
      longestStreak: 12,
      lastActivityAt: DateTime.now().subtract(const Duration(hours: 4)),
    );
  }

  @override
  Future<ParentChildQuizSpeedEntity> getQuizSpeed(String childId) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    final timeline = List.generate(6, (i) {
      return ParentQuizSpeedPoint(
        date: DateTime(now.year, now.month - (5 - i), 1),
        averageSecondsPerQuestion: 45 - i * 1.3,
        quizCount: 4 + i,
      );
    });
    return ParentChildQuizSpeedEntity(
      overallAverageSecondsPerQuestion: 38.6,
      totalQuizzes: timeline.fold(0, (sum, p) => sum + p.quizCount),
      timeline: timeline,
    );
  }
}
