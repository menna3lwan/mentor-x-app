import 'package:mentorx_core/mentorx_core.dart';

final class ParentGradeSummaryModel extends ParentGradeSummaryEntity {
  const ParentGradeSummaryModel({
    required super.overallAverage,
    super.trend = 'stable',
    super.trendChange = 0.0,
    super.totalAssessments = 0,
    super.graded = 0,
    super.pending = 0,
    super.passed = 0,
    super.failed = 0,
    super.distribution = const {},
    super.byCourse = const [],
  });

  factory ParentGradeSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParentGradeSummaryModel(
      overallAverage: ModelParser.asDouble(json['overall_average'] ?? json['overallAverage']),
      trend: ModelParser.asString(json['trend'], fallback: 'stable'),
      trendChange: ModelParser.asDouble(json['trend_change'] ?? json['trendChange']),
      totalAssessments: ModelParser.asInt(json['total_assessments'] ?? json['totalAssessments']),
      graded: ModelParser.asInt(json['graded']),
      pending: ModelParser.asInt(json['pending']),
      passed: ModelParser.asInt(json['passed']),
      failed: ModelParser.asInt(json['failed']),
      distribution: ModelParser.asMap(json['distribution'] ?? json['distribution_range'])
          .map((k, v) => MapEntry(k.toString(), ModelParser.asInt(v))),
      byCourse: ModelParser.asList(json['by_course'] ?? json['byCourse'])
          .map((e) => ParentCourseGradeSummaryModel.fromJson(ModelParser.asMap(e)))
          .toList(),
    );
  }
}

final class ParentCourseGradeSummaryModel extends ParentCourseGradeSummary {
  const ParentCourseGradeSummaryModel({
    required super.courseId,
    required super.courseTitle,
    required super.average,
    required super.assessmentsCount,
  });

  factory ParentCourseGradeSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParentCourseGradeSummaryModel(
      courseId: ModelParser.asString(json['course_id'] ?? json['courseId']),
      courseTitle: ModelParser.asString(json['course_title'] ?? json['courseTitle']),
      average: ModelParser.asDouble(json['average']),
      assessmentsCount: ModelParser.asInt(json['assessments_count'] ?? json['assessmentsCount']),
    );
  }
}

final class ParentGradeTrendModel extends ParentGradeTrendEntity {
  const ParentGradeTrendModel({
    required super.months,
  });

  factory ParentGradeTrendModel.fromJson(Map<String, dynamic> json) {
    return ParentGradeTrendModel(
      months: ModelParser.asList(json['months'])
          .map((e) => MonthlyGradeModel.fromJson(ModelParser.asMap(e)))
          .toList(),
    );
  }
}

final class MonthlyGradeModel extends MonthlyGradeEntry {
  const MonthlyGradeModel({
    required super.month,
    required super.average,
  });

  factory MonthlyGradeModel.fromJson(Map<String, dynamic> json) {
    return MonthlyGradeModel(
      month: ModelParser.asString(json['month']),
      average: ModelParser.asDouble(json['average']),
    );
  }
}

final class QuizAttemptModel extends QuizAttemptEntity {
  const QuizAttemptModel({
    required super.id,
    required super.quizId,
    super.courseId,
    super.courseName,
    required super.attemptNumber,
    required super.status,
    required super.score,
    required super.totalMarks,
    required super.percentage,
    required super.passed,
    required super.startedAt,
    super.submittedAt,
    super.timeSpentSeconds = 0,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      id: ModelParser.asString(json['id']),
      quizId: ModelParser.asString(json['quiz_id'] ?? json['quizId']),
      courseId: ModelParser.asString(json['course_id'] ?? json['courseId']),
      courseName: ModelParser.asString(json['course_name'] ?? json['courseName']),
      attemptNumber: ModelParser.asInt(json['attempt_number'] ?? json['attemptNumber'], fallback: 1),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['status'], fallback: 'submitted'),
        orElse: () => QuizAttemptStatus.submitted,
      ),
      score: ModelParser.asInt(json['score']),
      totalMarks: ModelParser.asInt(json['total_marks'] ?? json['totalMarks'] ?? json['max_score'], fallback: 100),
      percentage: ModelParser.asDouble(json['percentage']),
      passed: ModelParser.asBool(json['passed'] ?? json['is_passed'] ?? json['isPassed']),
      startedAt: ModelParser.asDateTime(json['started_at'] ?? json['startedAt']) ?? DateTime.now(),
      submittedAt: ModelParser.asDateTime(json['submitted_at'] ?? json['submittedAt']),
      timeSpentSeconds: ModelParser.asInt(json['time_spent_seconds'] ?? json['timeSpentSeconds']),
    );
  }
}
