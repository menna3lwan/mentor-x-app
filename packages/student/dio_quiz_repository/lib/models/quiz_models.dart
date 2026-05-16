import 'package:mentorx_core/mentorx_core.dart';

// ─────────────────────────────────────────────────────────────────────────────
// QuizModel
// Maps to: QuizResponse (GET /api/quizzes content[])
// ─────────────────────────────────────────────────────────────────────────────
final class QuizModel extends QuizEntity {
  const QuizModel({
    required super.id,
    required super.title,
    super.description,
    super.active = true,
    super.deleted = false,
    super.timeRestricted = false,
    required super.durationMinutes,
    super.deadline,
    super.weekId,
    super.courseId,
    super.questions = const [],
    required super.totalMarks,
    super.passMarks = 0,
    super.questionsCount,
    super.createdAt,
    super.updatedAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    // API sends totalMarks and passingPercentage (or passMarks)
    final totalMarks = ModelParser.asInt(
      data['totalMarks'] ?? data['total_marks'],
    );
    final passingPercentage = ModelParser.asDouble(
      data['passingPercentage'] ?? data['passing_percentage'],
    );
    final passMarks = ModelParser.asInt(
      data['passMarks'] ?? data['pass_marks'],
      fallback: (totalMarks * passingPercentage / 100).round(),
    );

    final rawQuestions = ModelParser.asList(data['questions']);
    final questions = rawQuestions
        .map((e) => QuizQuestionModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return QuizModel(
      id: ModelParser.asString(data['id']),
      title: ModelParser.asString(data['title']),
      description: _nullableString(data['description']),
      active: ModelParser.asBool(data['active'], fallback: true),
      deleted: ModelParser.asBool(data['deleted']),
      timeRestricted: ModelParser.asBool(
        data['timeRestricted'] ?? data['time_restricted'],
      ),
      durationMinutes: ModelParser.asInt(
        data['durationMinutes'] ??
            data['duration_minutes'] ??
            data['timeLimitMinutes'] ??
            data['time_limit'],
      ),
      deadline: ModelParser.asDateTime(data['deadline']),
      weekId: ModelParser.asString(data['weekId'] ?? data['week_id']),
      courseId: ModelParser.asString(data['courseId'] ?? data['course_id']),
      totalMarks: totalMarks,
      passMarks: passMarks,
      questionsCount: ModelParser.asInt(
        data['questionsCount'] ?? data['questions_count'] ?? questions.length,
      ),
      questions: questions,
      createdAt: ModelParser.asDateTime(
        data['createdAt'] ?? data['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        data['updatedAt'] ?? data['updated_at'],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QuizQuestionModel
// Maps to: QuizQuestionResponse (Nested in QuizModel or from /questions/quiz/id)
// ─────────────────────────────────────────────────────────────────────────────
final class QuizQuestionModel extends QuizQuestionEntity {
  const QuizQuestionModel({
    required super.id,
    required super.description,
    super.imageUrl,
    super.mark = 0,
    super.options = const [],
    super.optionsCount,
    super.type = QuizQuestionType.multipleChoice,
    super.order = 0,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    final rawOptions = ModelParser.asList(data['options']);
    final options = rawOptions.map((e) => e.toString()).toList();

    return QuizQuestionModel(
      id: ModelParser.asString(data['id']),
      description: ModelParser.asString(
        data['description'] ?? data['text'] ?? data['title'],
      ),
      type: _parseType(data['type']),
      imageUrl: _nullableString(data['imageUrl'] ?? data['image_url']),
      mark: ModelParser.asInt(data['mark']),
      optionsCount: ModelParser.asInt(
        data['optionsCount'] ?? data['options_count'] ?? options.length,
      ),
      order: ModelParser.asInt(
        data['order'] ?? data['order_number'] ?? data['orderIndex'],
      ),
      options: options,
    );
  }

  static QuizQuestionType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    for (final type in QuizQuestionType.values) {
      if (type.name.toLowerCase() == str) return type;
    }
    if (str == 'mcq') return QuizQuestionType.multipleChoice;
    if (str == 'tf') return QuizQuestionType.trueFalse;
    return QuizQuestionType.multipleChoice;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QuizAttemptModel
// Maps to: QuizAttemptResponse (POST /api/quizzes/{id}/submit, GET /results)
// ─────────────────────────────────────────────────────────────────────────────
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
    super.expiresAt,
    super.timeSpentSeconds = 0,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    final bool isSubmitted = ModelParser.asBool(data['submitted']);
    final startedAt = ModelParser.asDateTime(
      data['startedAt'] ?? data['started_at'],
    );
    final submittedAt = ModelParser.asDateTime(
      data['submittedAt'] ?? data['submitted_at'],
    );
    final expiresAt = ModelParser.asDateTime(
      data['expiresAt'] ?? data['expires_at'],
    );

    int timeSpent = ModelParser.asInt(
      data['timeSpentSeconds'] ?? data['time_spent_seconds'],
    );
    if (timeSpent == 0 && startedAt != null && submittedAt != null) {
      timeSpent = submittedAt.difference(startedAt).inSeconds;
    }

    return QuizAttemptModel(
      id: ModelParser.asString(
        data['attemptId'] ?? data['id'] ?? data['attempt_id'],
      ),
      quizId: ModelParser.asString(data['quizId'] ?? data['quiz_id']),
      courseId: ModelParser.asString(data['courseId'] ?? data['course_id']),
      courseName: ModelParser.asString(
        data['courseName'] ?? data['quizTitle'] ?? data['quiz_title'],
      ),
      attemptNumber: ModelParser.asInt(
        data['attemptNumber'] ?? data['attempt_number'],
      ),
      status: _parseStatus(
        data['status'] ?? (isSubmitted ? 'submitted' : 'in_progress'),
      ),
      answers: _parseAnswers(data['answers']),
      score: ModelParser.asInt(data['score']),
      totalMarks: ModelParser.asInt(data['totalMarks'] ?? data['total_marks']),
      percentage: ModelParser.asDouble(data['percentage']),
      passed: ModelParser.asBool(data['passed']),
      startedAt: startedAt ?? DateTime.now(),
      submittedAt: submittedAt,
      expiresAt: expiresAt,
      timeSpentSeconds: timeSpent,
    );
  }

  static Map<String, String> _parseAnswers(dynamic json) {
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    if (json is List) {
      final map = <String, String>{};
      for (final item in json) {
        final entry = ModelParser.asMap(item);
        final qId = ModelParser.asString(
          entry['questionId'] ?? entry['question_id'],
        );
        final ans = ModelParser.asString(
          entry['selectedAnswer'] ??
              entry['selected_answer'] ??
              entry['answer'],
        );
        if (qId.isNotEmpty) {
          map[qId] = ans;
        }
      }
      return map;
    }
    return const {};
  }

  static QuizAttemptStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'completed' || str == 'submitted' || str == 'finished') {
      return QuizAttemptStatus.submitted;
    }
    if (str == 'started' || str == 'in_progress' || str == 'active') {
      return QuizAttemptStatus.inProgress;
    }

    return QuizAttemptStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => QuizAttemptStatus.inProgress,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers
// ─────────────────────────────────────────────────────────────────────────────
String? _nullableString(dynamic value) {
  final s = ModelParser.asString(value);
  return s.isEmpty ? null : s;
}
