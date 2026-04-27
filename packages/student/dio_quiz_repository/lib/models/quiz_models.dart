import 'package:mentorx_core/mentorx_core.dart';

final class QuizModel extends QuizEntity {
  const QuizModel({
    required super.id,
    required super.title,
    super.active = true,
    super.timeRestricted = false,
    required super.durationMinutes,
    super.questions = const [],
    required super.totalMarks,
    super.questionsCount,
    super.createdAt,
    super.updatedAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      active: json['active'] ?? true,
      timeRestricted: json['timeRestricted'] ?? false,
      durationMinutes: (json['durationMinutes'] ?? 0).toInt(),
      totalMarks: (json['totalMarks'] ?? 0).toInt(),
      questionsCount: json['questionsCount']?.toInt(),
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt:
          json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}

final class QuizQuestionModel extends QuizQuestionEntity {
  const QuizQuestionModel({
    required super.id,
    required super.text,
    required super.type,
    super.imageUrl,
    super.options = const [],
    super.mark = 0,
    super.optionsCount,
    super.order = 0,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id']?.toString() ?? '',
      text: json['description'] ?? json['text'] ?? '',
      type: QuizQuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuizQuestionType.multipleChoice,
      ),
      imageUrl: json['imageUrl'],
      mark: (json['mark'] ?? 0).toInt(),
      optionsCount: json['optionsCount']?.toInt(),
      order: (json['order'] ?? 0).toInt(),
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
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
    super.answers = const {},
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
      quizId: (json['quizId'] ?? json['quiz_id'])?.toString() ?? '',
      courseId: (json['courseId'] ?? json['course_id'])?.toString(),
      courseName: (json['courseName'] ?? json['course_name'])?.toString(),
      attemptNumber: (json['attemptNumber'] ?? json['attempt_number'] ?? 0).toInt(),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'inProgress'),
        orElse: () => QuizAttemptStatus.inProgress,
      ),
      answers: (json['answers'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
          ) ??
          const {},
      score: (json['score'] ?? 0).toInt(),
      totalMarks: (json['totalMarks'] ?? json['total_marks'] ?? 0).toInt(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? false,
      startedAt: DateTime.tryParse(json['startedAt'] ?? json['started_at'] ?? '') ??
          DateTime.now(),
      submittedAt: (json['submittedAt'] ?? json['submitted_at']) != null
          ? DateTime.tryParse(json['submittedAt'] ?? json['submitted_at'])
          : null,
      timeSpentSeconds:
          (json['timeSpentSeconds'] ?? json['time_spent_seconds'] ?? 0).toInt(),
    );
  }
}
