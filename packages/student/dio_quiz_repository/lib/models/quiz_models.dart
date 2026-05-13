import 'package:mentorx_core/mentorx_core.dart';

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
    // API sends totalMarks and passingPercentage (or passMarks)
    final totalMarks = ModelParser.asInt(json['totalMarks'] ?? json['total_marks']);
    final passingPercentage = ModelParser.asDouble(json['passingPercentage'] ?? json['passing_percentage']);
    final passMarks = ModelParser.asInt(
      json['passMarks'] ?? json['pass_marks'],
      fallback: (totalMarks * passingPercentage / 100).round(),
    );

    return QuizModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      active: ModelParser.asBool(json['active'], fallback: true),
      deleted: ModelParser.asBool(json['deleted']),
      timeRestricted: ModelParser.asBool(json['timeRestricted'] ?? json['time_restricted']),
      durationMinutes: ModelParser.asInt(
        json['durationMinutes'] ?? json['duration_minutes'] ?? json['timeLimitMinutes'] ?? json['time_limit'],
      ),
      deadline: ModelParser.asDateTime(json['deadline']),
      weekId: ModelParser.asString(json['weekId'] ?? json['week_id']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      totalMarks: totalMarks,
      passMarks: passMarks,
      questionsCount: ModelParser.asInt(json['questionsCount'] ?? json['questions_count']),
      questions: ModelParser.asList(json['questions'])
          .map((e) => QuizQuestionModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
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
      id: ModelParser.asString(json['id']),
      text: ModelParser.asString(json['description'] ?? json['text'] ?? json['title']),
      type: _parseType(json['type']),
      imageUrl: ModelParser.asString(json['imageUrl'] ?? json['image_url']),
      mark: ModelParser.asInt(json['mark']),
      optionsCount: ModelParser.asInt(json['optionsCount'] ?? json['options_count']),
      order: ModelParser.asInt(json['order'] ?? json['order_number']),
      options: ModelParser.asList(json['options'])
          .map((e) => e.toString())
          .toList(),
    );
  }

  static QuizQuestionType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    // Support matching enum name or value
    for (final type in QuizQuestionType.values) {
      if (type.name.toLowerCase() == str) return type;
    }
    return QuizQuestionType.multipleChoice;
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
    final bool isSubmitted = ModelParser.asBool(json['submitted']);
    final startedAt = ModelParser.asDateTime(json['startedAt'] ?? json['started_at']);
    final submittedAt = ModelParser.asDateTime(json['submittedAt'] ?? json['submitted_at']);
    
    int timeSpent = ModelParser.asInt(json['timeSpentSeconds'] ?? json['time_spent_seconds']);
    if (timeSpent == 0 && startedAt != null && submittedAt != null) {
      timeSpent = submittedAt.difference(startedAt).inSeconds;
    }

    return QuizAttemptModel(
      id: ModelParser.asString(
        json['attemptId'] ?? json['id'] ?? json['attempt_id'],
      ),
      quizId: ModelParser.asString(json['quizId'] ?? json['quiz_id']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      courseName: ModelParser.asString(json['courseName'] ?? json['quizTitle'] ?? json['quiz_title']),
      attemptNumber: ModelParser.asInt(json['attemptNumber'] ?? json['attempt_number']),
      status: _parseStatus(json['status'] ?? (isSubmitted ? 'submitted' : 'in_progress')),
      answers: _parseAnswers(json['answers']),
      score: ModelParser.asInt(json['score']),
      totalMarks: ModelParser.asInt(json['totalMarks'] ?? json['total_marks']),
      percentage: ModelParser.asDouble(json['percentage']),
      passed: ModelParser.asBool(json['passed']),
      startedAt: startedAt ?? DateTime.now(),
      submittedAt: submittedAt,
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
        final qId = ModelParser.asString(entry['questionId'] ?? entry['question_id']);
        final ans = ModelParser.asString(entry['selectedAnswer'] ?? entry['selected_answer'] ?? entry['answer']);
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
    if (str == 'completed' || str == 'submitted') return QuizAttemptStatus.submitted;
    if (str == 'started' || str == 'in_progress' || str == 'active') return QuizAttemptStatus.inProgress;
    
    return QuizAttemptStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => QuizAttemptStatus.inProgress,
    );
  }
}
