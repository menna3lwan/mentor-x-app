part of 'package:mentorx_core/mentorx_core.dart';

class ParentGradeSummaryEntity extends Equatable {
  final double overallAverage;
  final String trend; // "up" / "down" / "stable"
  final double trendChange;
  final int totalAssessments;
  final int graded;
  final int pending;
  final int passed;
  final int failed;
  final Map<String, int> distribution; // e.g. {"excellent": 4, "good": 5, ...}
  final List<ParentCourseGradeSummary> byCourse;

  const ParentGradeSummaryEntity({
    required this.overallAverage,
    this.trend = 'stable',
    this.trendChange = 0.0,
    this.totalAssessments = 0,
    this.graded = 0,
    this.pending = 0,
    this.passed = 0,
    this.failed = 0,
    this.distribution = const {},
    this.byCourse = const [],
  });

  static const placeholder = ParentGradeSummaryEntity(
    overallAverage: 0.0,
  );

  @override
  List<Object?> get props => [
        overallAverage,
        trend,
        trendChange,
        totalAssessments,
        graded,
        pending,
        passed,
        failed,
        distribution,
        byCourse,
      ];
}

class ParentCourseGradeSummary extends Equatable {
  final String courseId;
  final String courseTitle;
  final double average;
  final int assessmentsCount;

  const ParentCourseGradeSummary({
    required this.courseId,
    required this.courseTitle,
    required this.average,
    required this.assessmentsCount,
  });

  @override
  List<Object?> get props => [courseId, courseTitle, average, assessmentsCount];
}

class MonthlyGradeEntry extends Equatable {
  final String month;
  final double average;

  const MonthlyGradeEntry({
    required this.month,
    required this.average,
  });

  @override
  List<Object?> get props => [month, average];
}

class ParentGradeTrendEntity extends Equatable {
  final List<MonthlyGradeEntry> months;

  const ParentGradeTrendEntity({
    required this.months,
  });

  static const placeholder = ParentGradeTrendEntity(months: []);

  @override
  List<Object?> get props => [months];
}
