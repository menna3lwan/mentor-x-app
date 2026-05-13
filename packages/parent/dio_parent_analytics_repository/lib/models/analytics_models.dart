import 'package:mentorx_core/mentorx_core.dart';

final class PerformanceSnapshotModel extends PerformanceSnapshotEntity {
  const PerformanceSnapshotModel({
    required super.label,
    required super.studentScore,
    required super.averageScore,
    required super.date,
  });

  factory PerformanceSnapshotModel.fromJson(Map<String, dynamic> json) {
    return PerformanceSnapshotModel(
      label: ModelParser.asString(json['label'] ?? json['title']),
      studentScore: ModelParser.asDouble(json['studentScore'] ?? json['student_score']),
      averageScore: ModelParser.asDouble(json['averageScore'] ?? json['average_score']),
      date: ModelParser.asDateTime(json['date'] ?? json['timestamp']) ?? DateTime.now(),
    );
  }
}

final class ActivityHeatmapModel extends ActivityHeatmapEntity {
  const ActivityHeatmapModel({
    required super.dayOfWeek,
    required super.hourOfDay,
    required super.intensity,
  });

  factory ActivityHeatmapModel.fromJson(Map<String, dynamic> json) {
    return ActivityHeatmapModel(
      dayOfWeek: ModelParser.asInt(json['dayOfWeek'] ?? json['day_of_week']),
      hourOfDay: ModelParser.asInt(json['hourOfDay'] ?? json['hour_of_day']),
      intensity: ModelParser.asInt(json['intensity']),
    );
  }
}

final class AchievementModel extends AchievementEntity {
  const AchievementModel({
    required super.id,
    required super.title,
    required super.description,
    required super.iconUrl,
    required super.isUnlocked,
    super.unlockedAt,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      iconUrl: ModelParser.asString(json['iconUrl'] ?? json['icon_url']),
      isUnlocked: ModelParser.asBool(json['isUnlocked'] ?? json['unlocked'] ?? json['is_unlocked']),
      unlockedAt: ModelParser.asDateTime(json['unlockedAt'] ?? json['unlocked_at']),
    );
  }
}

final class StreakModel extends StreakEntity {
  const StreakModel({
    required super.currentStreak,
    required super.longestStreak,
    super.lastActivityAt,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentStreak: ModelParser.asInt(json['currentStreak'] ?? json['current_streak']),
      longestStreak: ModelParser.asInt(json['longestStreak'] ?? json['longest_streak']),
      lastActivityAt: ModelParser.asDateTime(json['lastActivityAt'] ?? json['last_activity_at']),
    );
  }
}

final class QuizSpeedMetricModel extends QuizSpeedMetricEntity {
  const QuizSpeedMetricModel({
    required super.quizId,
    required super.quizTitle,
    required super.timeSpentSeconds,
    required super.questionCount,
    required super.secondsPerQuestion,
    required super.averageSecondsPerQuestion,
  });

  factory QuizSpeedMetricModel.fromJson(Map<String, dynamic> json) {
    return QuizSpeedMetricModel(
      quizId: ModelParser.asString(json['quizId'] ?? json['quiz_id']),
      quizTitle: ModelParser.asString(json['quizTitle'] ?? json['quiz_title']),
      timeSpentSeconds: ModelParser.asInt(json['timeSpentSeconds'] ?? json['time_spent_seconds']),
      questionCount: ModelParser.asInt(json['questionCount'] ?? json['question_count']),
      secondsPerQuestion: ModelParser.asDouble(json['secondsPerQuestion'] ?? json['seconds_per_question']),
      averageSecondsPerQuestion: ModelParser.asDouble(json['averageSecondsPerQuestion'] ?? json['average_seconds_per_question']),
    );
  }
}
