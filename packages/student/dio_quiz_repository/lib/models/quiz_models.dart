import 'package:mentorx_core/mentorx_core.dart';

final class QuizModel extends QuizEntity {
  const QuizModel({
    required super.id,
    required super.title,
    required super.durationMinutes,
    required super.totalMarks,
    super.maxAttempts = 1,
    super.passPercentage = 50,
    super.shuffleQuestions = false,
    super.shuffleOptions = false,
    super.questionsPerAttempt,
    super.showCorrectAnswers = true,
    super.showExplanations = true,
    super.showScoreImmediately = true,
    super.availableFrom,
    super.availableUntil,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      durationMinutes: (json['duration_minutes'] ?? 0).toInt(),
      totalMarks: (json['total_marks'] ?? 0).toInt(),
      maxAttempts: (json['max_attempts'] ?? 1).toInt(),
      passPercentage: (json['pass_percentage'] ?? 50.0).toDouble(),
      shuffleQuestions: json['shuffle_questions'] ?? false,
      shuffleOptions: json['shuffle_options'] ?? false,
      questionsPerAttempt: json['questions_per_attempt']?.toInt(),
      showCorrectAnswers: json['show_correct_answers'] ?? true,
      showExplanations: json['show_explanations'] ?? true,
      showScoreImmediately: json['show_score_immediately'] ?? true,
      availableFrom: json['available_from'] != null
          ? DateTime.tryParse(json['available_from'])
          : null,
      availableUntil: json['available_until'] != null
          ? DateTime.tryParse(json['available_until'])
          : null,
    );
  }
}

final class QuizQuestionModel extends QuizQuestionEntity {
  const QuizQuestionModel({
    required super.id,
    required super.questionText,
    required super.questionType,
    required super.marks,
    super.questionImageUrl,
    super.options = const [],
    super.negativeMarks = 0,
    super.explanation,
    super.order = 0,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id']?.toString() ?? '',
      questionText: json['question_text'] ?? '',
      questionImageUrl: json['question_image_url'],
      questionType: QuizQuestionType.values.firstWhere(
        (e) => e.name == (json['question_type'] ?? 'mcqSingle'),
        orElse: () => QuizQuestionType.multipleChoice,
      ),
      marks: (json['marks'] ?? 0).toInt(),
      negativeMarks: (json['negative_marks'] ?? 0).toInt(),
      explanation: json['explanation'],
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
      courseName: json['course_name']?.toString(),
      attemptNumber: (json['attempt_number'] ?? 0).toInt(),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'inProgress'),
        orElse: () => QuizAttemptStatus.inProgress,
      ),
      score: (json['score'] ?? 0).toInt(),
      totalMarks: (json['total_marks'] ?? 0).toInt(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? false,
      startedAt: DateTime.tryParse(json['started_at'] ?? '') ?? DateTime.now(),
      submittedAt: json['submitted_at'] != null
          ? DateTime.tryParse(json['submitted_at'])
          : null,
      timeSpentSeconds: (json['time_spent_seconds'] ?? 0).toInt(),
    );
  }
}
