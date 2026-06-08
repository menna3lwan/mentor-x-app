import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────
// Grade comparison
// ─────────────────────────────────────────────────────────────────────────

final class ParentGradeComparisonRowModel extends ParentGradeComparisonRow {
  const ParentGradeComparisonRowModel({
    required super.label,
    required super.childScore,
    required super.classAverage,
  });

  factory ParentGradeComparisonRowModel.fromJson(Map<String, dynamic> json) {
    return ParentGradeComparisonRowModel(
      label: ModelParser.asString(
        json['label'] ??
            json['subject'] ??
            json['courseName'] ??
            json['course_name'],
      ),
      childScore: ModelParser.asDouble(
        json['childScore'] ??
            json['child_score'] ??
            json['studentScore'] ??
            json['student_score'] ??
            json['score'],
      ),
      classAverage: ModelParser.asDouble(
        json['classAverage'] ??
            json['class_average'] ??
            json['average'] ??
            json['avg'],
      ),
    );
  }
}

final class ParentChildGradeComparisonModel
    extends ParentChildGradeComparisonEntity {
  const ParentChildGradeComparisonModel({
    required super.childOverallAverage,
    required super.classOverallAverage,
    super.rank,
    super.totalStudents,
    super.rows,
  });

  factory ParentChildGradeComparisonModel.fromJson(Map<String, dynamic> json) {
    final rowsList = ModelParser.asList(
      json['rows'] ??
          json['subjects'] ??
          json['courses'] ??
          json['comparisons'] ??
          json['content'],
    );
    return ParentChildGradeComparisonModel(
      // Backend (Swagger StudentGradeComparisonDto):
      //   { myAvgPercentage, classAvgPercentage, myRank, totalStudents }
      childOverallAverage: ModelParser.asDouble(
        json['myAvgPercentage'] ??
            json['my_avg_percentage'] ??
            json['childOverallAverage'] ??
            json['child_overall_average'] ??
            json['studentAverage'] ??
            json['student_average'],
      ),
      classOverallAverage: ModelParser.asDouble(
        json['classAvgPercentage'] ??
            json['class_avg_percentage'] ??
            json['classOverallAverage'] ??
            json['class_overall_average'] ??
            json['classAverage'] ??
            json['class_average'],
      ),
      rank: ModelParser.asInt(json['myRank'] ?? json['my_rank'] ?? json['rank']),
      totalStudents: ModelParser.asInt(
        json['totalStudents'] ?? json['total_students'],
      ),
      rows: rowsList
          .map(ModelParser.asMap)
          .map(ParentGradeComparisonRowModel.fromJson)
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Course progress
// ─────────────────────────────────────────────────────────────────────────

final class ParentCourseProgressRowModel extends ParentCourseProgressRow {
  const ParentCourseProgressRowModel({
    required super.courseId,
    required super.courseName,
    required super.progressPercent,
    required super.sessionsTotal,
    required super.sessionsCompleted,
  });

  factory ParentCourseProgressRowModel.fromJson(Map<String, dynamic> json) {
    return ParentCourseProgressRowModel(
      courseId: ModelParser.asString(
        json['courseId'] ?? json['course_id'] ?? json['id'],
      ),
      // Backend (Swagger ProgressSummaryDto) sends `courseTitle`.
      courseName: ModelParser.asString(
        json['courseTitle'] ??
            json['course_title'] ??
            json['courseName'] ??
            json['course_name'] ??
            json['title'] ??
            '',
      ),
      progressPercent: ModelParser.asDouble(
        json['progressPercent'] ??
            json['progress_percent'] ??
            json['progress'] ??
            json['percent'],
      ),
      sessionsTotal: ModelParser.asInt(
        json['sessionsTotal'] ??
            json['sessions_total'] ??
            json['totalSessions'] ??
            json['total_sessions'],
      ),
      sessionsCompleted: ModelParser.asInt(
        json['sessionsCompleted'] ??
            json['sessions_completed'] ??
            json['completedSessions'] ??
            json['completed_sessions'],
      ),
    );
  }
}

final class ParentChildCourseProgressModel
    extends ParentChildCourseProgressEntity {
  const ParentChildCourseProgressModel({
    super.courses,
    super.overallPercent,
  });

  factory ParentChildCourseProgressModel.fromJson(Map<String, dynamic> json) {
    final list = ModelParser.asList(
      json['courses'] ?? json['content'] ?? json['items'],
    );
    return ParentChildCourseProgressModel(
      overallPercent: ModelParser.asDouble(
        json['overallPercent'] ??
            json['overall_percent'] ??
            json['overall'] ??
            json['average'],
      ),
      courses: list
          .map(ModelParser.asMap)
          .map(ParentCourseProgressRowModel.fromJson)
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Active hours
// ─────────────────────────────────────────────────────────────────────────

final class ParentActiveDayModel extends ParentActiveDayEntity {
  const ParentActiveDayModel({required super.date, required super.minutes});

  factory ParentActiveDayModel.fromJson(Map<String, dynamic> json) {
    return ParentActiveDayModel(
      date:
          ModelParser.asDateTime(json['date'] ?? json['day']) ?? DateTime.now(),
      minutes: ModelParser.asInt(
        json['minutes'] ?? json['totalMinutes'] ?? json['total_minutes'],
      ),
    );
  }
}

final class ParentChildActiveHoursModel
    extends ParentChildActiveHoursEntity {
  const ParentChildActiveHoursModel({
    super.days,
    super.totalMinutes,
    super.averageMinutesPerDay,
  });

  factory ParentChildActiveHoursModel.fromJson(Map<String, dynamic> json) {
    final list = ModelParser.asList(
      json['days'] ?? json['daily'] ?? json['content'],
    );
    return ParentChildActiveHoursModel(
      days: list
          .map(ModelParser.asMap)
          .map(ParentActiveDayModel.fromJson)
          .toList(),
      totalMinutes: ModelParser.asInt(
        json['totalMinutes'] ?? json['total_minutes'],
      ),
      averageMinutesPerDay: ModelParser.asInt(
        json['averageMinutesPerDay'] ??
            json['average_minutes_per_day'] ??
            json['averagePerDay'] ??
            json['average'],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Achievements
// ─────────────────────────────────────────────────────────────────────────

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
      title: ModelParser.asString(json['title'] ?? json['name']),
      description: ModelParser.asString(json['description']),
      iconUrl: ModelParser.asString(
        json['iconUrl'] ?? json['icon_url'] ?? json['icon'],
      ),
      isUnlocked: ModelParser.asBool(
        json['isUnlocked'] ??
            json['is_unlocked'] ??
            json['unlocked'] ??
            json['earned'],
      ),
      unlockedAt: ModelParser.asDateTime(
        json['unlockedAt'] ??
            json['unlocked_at'] ??
            json['earnedAt'] ??
            json['earned_at'],
      ),
    );
  }
}

final class ParentChildAchievementsModel
    extends ParentChildAchievementsEntity {
  const ParentChildAchievementsModel({
    super.achievements,
    super.totalUnlocked,
  });

  factory ParentChildAchievementsModel.fromJson(Map<String, dynamic> json) {
    final list = ModelParser.asList(
      json['achievements'] ?? json['content'] ?? json['items'],
    );
    final mapped = list
        .map(ModelParser.asMap)
        .map(AchievementModel.fromJson)
        .toList();
    return ParentChildAchievementsModel(
      achievements: mapped,
      totalUnlocked: ModelParser.asInt(
        json['totalUnlocked'] ??
            json['total_unlocked'] ??
            mapped.where((a) => a.isUnlocked).length,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Streak
// ─────────────────────────────────────────────────────────────────────────

final class ParentChildStreakModel extends StreakEntity {
  const ParentChildStreakModel({
    required super.currentStreak,
    required super.longestStreak,
    super.lastActivityAt,
  });

  factory ParentChildStreakModel.fromJson(Map<String, dynamic> json) {
    // Backend (Swagger StreakDto):
    //   { currentStreakDays, longestStreakDays, lastActivityDate,
    //     totalActiveDays, loginCount }
    return ParentChildStreakModel(
      currentStreak: ModelParser.asInt(
        json['currentStreakDays'] ??
            json['current_streak_days'] ??
            json['currentStreak'] ??
            json['current_streak'] ??
            json['current'],
      ),
      longestStreak: ModelParser.asInt(
        json['longestStreakDays'] ??
            json['longest_streak_days'] ??
            json['longestStreak'] ??
            json['longest_streak'] ??
            json['longest'],
      ),
      lastActivityAt: ModelParser.asDateTime(
        json['lastActivityDate'] ??
            json['last_activity_date'] ??
            json['lastActivityAt'] ??
            json['last_activity_at'] ??
            json['lastActiveAt'] ??
            json['last_active_at'],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Quiz speed
// ─────────────────────────────────────────────────────────────────────────

final class ParentQuizSpeedPointModel extends ParentQuizSpeedPoint {
  const ParentQuizSpeedPointModel({
    required super.date,
    required super.averageSecondsPerQuestion,
    required super.quizCount,
  });

  factory ParentQuizSpeedPointModel.fromJson(Map<String, dynamic> json) {
    // Backend (Swagger QuizSpeedDto):
    //   { quizId, quizTitle, score, durationSeconds, submittedAt }
    return ParentQuizSpeedPointModel(
      date: ModelParser.asDateTime(
        json['submittedAt'] ??
            json['submitted_at'] ??
            json['date'] ??
            json['day'],
      ) ?? DateTime.now(),
      averageSecondsPerQuestion: ModelParser.asDouble(
        json['durationSeconds'] ??
            json['duration_seconds'] ??
            json['averageSecondsPerQuestion'] ??
            json['average_seconds_per_question'] ??
            json['avgSecondsPerQuestion'] ??
            json['avg_seconds_per_question'],
      ),
      quizCount: ModelParser.asInt(
        json['quizCount'] ?? json['quiz_count'] ?? json['count'],
        // If coming from QuizSpeedDto, each row is one quiz → count = 1.
      ),
    );
  }
}

final class ParentChildQuizSpeedModel extends ParentChildQuizSpeedEntity {
  const ParentChildQuizSpeedModel({
    super.overallAverageSecondsPerQuestion,
    super.totalQuizzes,
    super.timeline,
  });

  factory ParentChildQuizSpeedModel.fromJson(Map<String, dynamic> json) {
    final list = ModelParser.asList(
      json['timeline'] ??
          json['points'] ??
          json['history'] ??
          json['content'],
    );
    return ParentChildQuizSpeedModel(
      overallAverageSecondsPerQuestion: ModelParser.asDouble(
        json['overallAverageSecondsPerQuestion'] ??
            json['overall_average_seconds_per_question'] ??
            json['averageSecondsPerQuestion'] ??
            json['average_seconds_per_question'],
      ),
      totalQuizzes: ModelParser.asInt(
        json['totalQuizzes'] ?? json['total_quizzes'] ?? json['count'],
      ),
      timeline: list
          .map(ModelParser.asMap)
          .map(ParentQuizSpeedPointModel.fromJson)
          .toList(),
    );
  }
}
