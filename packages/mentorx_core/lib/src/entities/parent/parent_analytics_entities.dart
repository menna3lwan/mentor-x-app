part of 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────
// Grade comparison
// ─────────────────────────────────────────────────────────────────────────

/// One row of a child-vs-class grade comparison (per subject / course).
class ParentGradeComparisonRow extends Equatable {
  final String label;
  final double childScore;
  final double classAverage;

  const ParentGradeComparisonRow({
    required this.label,
    required this.childScore,
    required this.classAverage,
  });

  @override
  List<Object?> get props => [label, childScore, classAverage];
}

class ParentChildGradeComparisonEntity extends Equatable {
  final double childOverallAverage;
  final double classOverallAverage;
  final int rank;
  final int totalStudents;
  final List<ParentGradeComparisonRow> rows;

  const ParentChildGradeComparisonEntity({
    required this.childOverallAverage,
    required this.classOverallAverage,
    this.rank = 0,
    this.totalStudents = 0,
    this.rows = const [],
  });

  static const empty = ParentChildGradeComparisonEntity(
    childOverallAverage: 0,
    classOverallAverage: 0,
  );

  @override
  List<Object?> get props => [
    childOverallAverage,
    classOverallAverage,
    rank,
    totalStudents,
    rows,
  ];
}

// ─────────────────────────────────────────────────────────────────────────
// Course progress
// ─────────────────────────────────────────────────────────────────────────

class ParentCourseProgressRow extends Equatable {
  final String courseId;
  final String courseName;
  final double progressPercent;
  final int sessionsTotal;
  final int sessionsCompleted;

  const ParentCourseProgressRow({
    required this.courseId,
    required this.courseName,
    required this.progressPercent,
    required this.sessionsTotal,
    required this.sessionsCompleted,
  });

  @override
  List<Object?> get props => [
    courseId,
    courseName,
    progressPercent,
    sessionsTotal,
    sessionsCompleted,
  ];
}

class ParentChildCourseProgressEntity extends Equatable {
  final List<ParentCourseProgressRow> courses;
  final double overallPercent;

  const ParentChildCourseProgressEntity({
    this.courses = const [],
    this.overallPercent = 0,
  });

  static const empty = ParentChildCourseProgressEntity();

  @override
  List<Object?> get props => [courses, overallPercent];
}

// ─────────────────────────────────────────────────────────────────────────
// Active hours
// ─────────────────────────────────────────────────────────────────────────

class ParentActiveDayEntity extends Equatable {
  final DateTime date;
  final int minutes;

  const ParentActiveDayEntity({required this.date, required this.minutes});

  @override
  List<Object?> get props => [date, minutes];
}

class ParentChildActiveHoursEntity extends Equatable {
  final List<ParentActiveDayEntity> days;
  final int totalMinutes;
  final int averageMinutesPerDay;

  const ParentChildActiveHoursEntity({
    this.days = const [],
    this.totalMinutes = 0,
    this.averageMinutesPerDay = 0,
  });

  static const empty = ParentChildActiveHoursEntity();

  @override
  List<Object?> get props => [days, totalMinutes, averageMinutesPerDay];
}

// ─────────────────────────────────────────────────────────────────────────
// Achievements list (parent view — read-only)
// ─────────────────────────────────────────────────────────────────────────

class ParentChildAchievementsEntity extends Equatable {
  final List<AchievementEntity> achievements;
  final int totalUnlocked;

  const ParentChildAchievementsEntity({
    this.achievements = const [],
    this.totalUnlocked = 0,
  });

  static const empty = ParentChildAchievementsEntity();

  @override
  List<Object?> get props => [achievements, totalUnlocked];
}

// ─────────────────────────────────────────────────────────────────────────
// Quiz speed summary (parent view)
// ─────────────────────────────────────────────────────────────────────────

class ParentQuizSpeedPoint extends Equatable {
  final DateTime date;
  final double averageSecondsPerQuestion;
  final int quizCount;

  const ParentQuizSpeedPoint({
    required this.date,
    required this.averageSecondsPerQuestion,
    required this.quizCount,
  });

  @override
  List<Object?> get props => [date, averageSecondsPerQuestion, quizCount];
}

class ParentChildQuizSpeedEntity extends Equatable {
  final double overallAverageSecondsPerQuestion;
  final int totalQuizzes;
  final List<ParentQuizSpeedPoint> timeline;

  const ParentChildQuizSpeedEntity({
    this.overallAverageSecondsPerQuestion = 0,
    this.totalQuizzes = 0,
    this.timeline = const [],
  });

  static const empty = ParentChildQuizSpeedEntity();

  @override
  List<Object?> get props => [
    overallAverageSecondsPerQuestion,
    totalQuizzes,
    timeline,
  ];
}
