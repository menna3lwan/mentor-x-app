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
      overallAverage: (json['overall_average'] ?? 0.0).toDouble(),
      trend: json['trend'] ?? 'stable',
      trendChange: (json['trend_change'] ?? 0.0).toDouble(),
      totalAssessments: (json['total_assessments'] ?? 0).toInt(),
      graded: (json['graded'] ?? 0).toInt(),
      pending: (json['pending'] ?? 0).toInt(),
      passed: (json['passed'] ?? 0).toInt(),
      failed: (json['failed'] ?? 0).toInt(),
      distribution: (json['distribution'] as Map? ?? {})
          .map((k, v) => MapEntry(k.toString(), (v ?? 0).toInt())),
      byCourse: (json['by_course'] as List? ?? [])
          .map((e) => ParentCourseGradeSummaryModel.fromJson(e as Map<String, dynamic>))
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
      courseId: json['course_id']?.toString() ?? '',
      courseTitle: json['course_title'] ?? '',
      average: (json['average'] ?? 0.0).toDouble(),
      assessmentsCount: (json['assessments_count'] ?? 0).toInt(),
    );
  }
}

final class ParentGradeTrendModel extends ParentGradeTrendEntity {
  const ParentGradeTrendModel({
    required super.months,
  });

  factory ParentGradeTrendModel.fromJson(Map<String, dynamic> json) {
    return ParentGradeTrendModel(
      months: (json['months'] as List? ?? [])
          .map((e) => MonthlyGradeModel.fromJson(e as Map<String, dynamic>))
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
      month: json['month'] ?? '',
      average: (json['average'] ?? 0.0).toDouble(),
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
      id: json['id']?.toString() ?? '',
      quizId: json['quiz_id']?.toString() ?? '',
      courseId: json['course_id']?.toString(),
      courseName: json['course_name'],
      attemptNumber: (json['attempt_number'] ?? 1).toInt(),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'submitted'),
        orElse: () => QuizAttemptStatus.submitted,
      ),
      score: (json['score'] ?? 0).toInt(),
      totalMarks: (json['total_marks'] ?? json['max_score'] ?? 100).toInt(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? json['is_passed'] ?? false,
      startedAt: json['started_at'] != null
          ? DateTime.tryParse(json['started_at']) ?? DateTime.now()
          : DateTime.now(),
      submittedAt: json['submitted_at'] != null ? DateTime.tryParse(json['submitted_at']) : null,
      timeSpentSeconds: (json['time_spent_seconds'] ?? 0).toInt(),
    );
  }
}
