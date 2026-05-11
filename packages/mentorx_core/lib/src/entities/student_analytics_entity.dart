part of 'package:mentorx_core/mentorx_core.dart';

class StudentAnalyticsSummaryEntity extends Equatable {
  final int rank;
  final int totalStudents;
  final double studentAverage;
  final double classAverage;
  final List<PerformanceSnapshotEntity> performanceTimeline;
  final List<ActivityHeatmapEntity> activityHeatmap;
  final List<AchievementEntity> achievements;
  final StreakEntity streak;
  final List<QuizSpeedMetricEntity> quizSpeedMetrics;

  const StudentAnalyticsSummaryEntity({
    required this.rank,
    required this.totalStudents,
    required this.studentAverage,
    required this.classAverage,
    this.performanceTimeline = const [],
    this.activityHeatmap = const [],
    this.achievements = const [],
    required this.streak,
    this.quizSpeedMetrics = const [],
  });

  @override
  List<Object?> get props => [
        rank,
        totalStudents,
        studentAverage,
        classAverage,
        performanceTimeline,
        activityHeatmap,
        achievements,
        streak,
        quizSpeedMetrics,
      ];
}

class PerformanceSnapshotEntity extends Equatable {
  final String label; // e.g., "Sep", "Oct" or "Course Name"
  final double studentScore;
  final double averageScore;
  final DateTime date;

  const PerformanceSnapshotEntity({
    required this.label,
    required this.studentScore,
    required this.averageScore,
    required this.date,
  });

  @override
  List<Object?> get props => [label, studentScore, averageScore, date];
}

class ActivityHeatmapEntity extends Equatable {
  final int dayOfWeek; // 1-7 (Mon-Sun)
  final int hourOfDay; // 0-23
  final int intensity; // 0-4 (like GitHub)

  const ActivityHeatmapEntity({
    required this.dayOfWeek,
    required this.hourOfDay,
    required this.intensity,
  });

  @override
  List<Object?> get props => [dayOfWeek, hourOfDay, intensity];
}

class AchievementEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.isUnlocked,
    this.unlockedAt,
  });

  @override
  List<Object?> get props => [id, title, description, iconUrl, isUnlocked, unlockedAt];
}

class StreakEntity extends Equatable {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivityAt;

  const StreakEntity({
    required this.currentStreak,
    required this.longestStreak,
    this.lastActivityAt,
  });

  @override
  List<Object?> get props => [currentStreak, longestStreak, lastActivityAt];
}

class QuizSpeedMetricEntity extends Equatable {
  final String quizId;
  final String quizTitle;
  final int timeSpentSeconds;
  final int questionCount;
  final double secondsPerQuestion;
  final double averageSecondsPerQuestion;

  const QuizSpeedMetricEntity({
    required this.quizId,
    required this.quizTitle,
    required this.timeSpentSeconds,
    required this.questionCount,
    required this.secondsPerQuestion,
    required this.averageSecondsPerQuestion,
  });

  @override
  List<Object?> get props => [
        quizId,
        quizTitle,
        timeSpentSeconds,
        questionCount,
        secondsPerQuestion,
        averageSecondsPerQuestion,
      ];
}
