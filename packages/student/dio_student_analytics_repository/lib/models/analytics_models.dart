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
        json['studentScore'] ?? json['student_score'],
      ),
      averageScore: ModelParser.asDouble(
        json['averageScore'] ?? json['average_score'],
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
      isUnlocked: ModelParser.asBool(
        json['isUnlocked'] ?? json['unlocked'] ?? json['is_unlocked'],
      ),
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
    super.totalActiveDays = 0,
    super.loginCount = 0,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentStreak: ModelParser.asInt(
        json['currentStreak'] ??
            json['currentStreakDays'] ??
            json['current_streak'],
      ),
      longestStreak: ModelParser.asInt(
        json['longestStreak'] ??
            json['longestStreakDays'] ??
            json['longest_streak'],
      ),
      lastActivityAt: ModelParser.asDateTime(
        json['lastActivityAt'] ??
            json['lastActivityDate'] ??
            json['last_activity_at'],
      ),
      totalActiveDays: ModelParser.asInt(
        json['totalActiveDays'] ?? json['total_active_days'],
      ),
      loginCount: ModelParser.asInt(json['loginCount'] ?? json['login_count']),
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
    final timeSpentSeconds = ModelParser.asInt(
      json['timeSpentSeconds'] ??
          json['durationSeconds'] ??
          json['time_spent_seconds'],
    );
    final questionCount =
        ModelParser.asInt(json['questionCount'] ?? json['question_count']);

    return QuizSpeedMetricModel(
      quizId: ModelParser.asString(json['quizId'] ?? json['quiz_id']),
      quizTitle: ModelParser.asString(json['quizTitle'] ?? json['quiz_title']),
      score: ModelParser.asInt(json['score']),
      timeSpentSeconds: timeSpentSeconds,
      questionCount: questionCount,
      averageSecondsPerQuestion: questionCount > 0
          ? timeSpentSeconds / questionCount
          : 0,
      submittedAt:
          ModelParser.asDateTime(json['submittedAt'] ?? json['submitted_at']) ??
          DateTime.now(),
    );
  }
}

final class StudentAnalyticsSummaryModel extends StudentAnalyticsSummaryEntity {
  const StudentAnalyticsSummaryModel({
    required super.rank,
    required super.totalStudents,
    required super.studentAverage,
    required super.classAverage,
    super.totalAttempts = 0,
    super.performanceTimeline = const [],
    super.activityHeatmap = const [],
    super.achievements = const [],
    required super.streak,
    super.quizSpeedMetrics = const [],
  });

  factory StudentAnalyticsSummaryModel.fromJson(Map<String, dynamic> json) {
    return StudentAnalyticsSummaryModel(
      rank: ModelParser.asInt(json['rank'] ?? json['myRank']),
      totalStudents: ModelParser.asInt(
        json['totalStudents'] ?? json['total_students'],
      ),
      studentAverage: ModelParser.asDouble(
        json['studentAverage'] ??
            json['myAvgPercentage'] ??
            json['student_average'],
      ),
      classAverage: ModelParser.asDouble(
        json['classAverage'] ??
            json['classAvgPercentage'] ??
            json['class_average'],
      ),
      totalAttempts: ModelParser.asInt(json['totalAttempts']),
      performanceTimeline:
          ModelParser.asList(
                json['performanceTimeline'] ?? json['performance_timeline'],
              )
              .map(
                (e) => PerformanceSnapshotModel.fromJson(ModelParser.asMap(e)),
              )
              .toList(),
      activityHeatmap:
          ModelParser.asList(
                json['activityHeatmap'] ?? json['activity_heatmap'],
              )
              .map((e) => ActivityHeatmapModel.fromJson(ModelParser.asMap(e)))
              .toList(),
      achievements: ModelParser.asList(
        json['achievements'],
      ).map((e) => AchievementModel.fromJson(ModelParser.asMap(e))).toList(),
      streak: StreakModel.fromJson(ModelParser.asMap(json['streak'])),
      quizSpeedMetrics:
          ModelParser.asList(
                json['quizSpeedMetrics'] ?? json['quiz_speed_metrics'],
              )
              .map((e) => QuizSpeedMetricModel.fromJson(ModelParser.asMap(e)))
              .toList(),
    );
  }
}
