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
      studentScore: ModelParser.asDouble(
        json['studentScore'] ?? json['myAvgPercentage'],
      ),
      averageScore: ModelParser.asDouble(
        json['averageScore'] ?? json['classAvgPercentage'],
      ),
      date:
          ModelParser.asDateTime(json['date'] ?? json['timestamp']) ??
          DateTime.now(),
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
      dayOfWeek: ModelParser.asInt(json['dayOfWeek'] ?? json['day']),
      hourOfDay: ModelParser.asInt(json['hourOfDay'] ?? json['hour']),
      intensity: ModelParser.asInt(json['intensity'] ?? json['count']),
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
      iconUrl: ModelParser.asString(json['icon'] ?? json['iconUrl']),
      isUnlocked: ModelParser.asBool(json['unlocked'] ?? json['isUnlocked']),
      unlockedAt: ModelParser.asDateTime(
        json['unlockedAt'] ?? json['unlocked_at'],
      ),
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
      currentStreak: ModelParser.asInt(
        json['currentStreakDays'] ?? json['currentStreak'],
      ),
      longestStreak: ModelParser.asInt(
        json['longestStreakDays'] ?? json['longestStreak'],
      ),
      lastActivityAt: ModelParser.asDateTime(
        json['lastActivityDate'] ?? json['lastActivityAt'],
      ),
    );
  }
}

final class QuizSpeedMetricModel extends QuizSpeedMetricEntity {
  const QuizSpeedMetricModel({
    required super.quizId,
    required super.quizTitle,
    required super.score,
    required super.timeSpentSeconds,
    required super.questionCount,
    required super.averageSecondsPerQuestion,
    required super.submittedAt,
  });

  factory QuizSpeedMetricModel.fromJson(Map<String, dynamic> json) {
    final int duration = ModelParser.asInt(
      json['durationSeconds'] ?? json['timeSpentSeconds'],
    );
    final int qCount = ModelParser.asInt(json['questionCount']);

    return QuizSpeedMetricModel(
      quizId: ModelParser.asString(json['quizId'] ?? json['id']),
      quizTitle: ModelParser.asString(json['quizTitle'] ?? json['title']),
      score: ModelParser.asInt(json['score']),
      timeSpentSeconds: duration,
      questionCount: qCount,
      averageSecondsPerQuestion: ModelParser.asDouble(
        json['averageSecondsPerQuestion'],
      ),
      submittedAt: ModelParser.asDateTime(
        json['submittedAt'] ?? json['submitted_at'],
      ) ?? DateTime.now(),
    );
  }
}
