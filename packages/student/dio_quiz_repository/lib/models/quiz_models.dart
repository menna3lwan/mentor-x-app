import 'package:mentorx_core/mentorx_core.dart';

abstract final class QuizAttemptModel {
  static QuizAttemptEntity fromJson(Map<String, dynamic> json) {
    return QuizAttemptEntity(
      id: json['id']?.toString() ?? '',
      quizId: json['quizId']?.toString() ?? json['quiz_id']?.toString() ?? '',
      attemptNumber: (json['attemptNumber'] ?? json['attempt_number'] as num?)?.toInt() ?? 1,
      status: _parseStatus(json['status']),
      score: (json['score'] as num?)?.toInt() ?? 0,
      totalMarks: (json['totalMarks'] ?? json['total_marks'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      passed: json['passed'] as bool? ?? json['is_passed'] as bool? ?? false,
      startedAt: DateTime.parse(json['startedAt'] as String? ?? json['started_at'] as String? ?? DateTime.now().toIso8601String()),
      submittedAt: (json['submittedAt'] ?? json['submitted_at']) != null 
          ? DateTime.parse((json['submittedAt'] ?? json['submitted_at']) as String) 
          : null,
      timeSpentSeconds: (json['timeSpentSeconds'] ?? json['time_spent_seconds'] as num?)?.toInt() ?? 0,
    );
  }

  static QuizAttemptStatus _parseStatus(dynamic value) {
    if (value == null) return QuizAttemptStatus.inProgress;
    final str = value.toString().toLowerCase();
    if (str == 'in_progress' || str == 'inprogress') return QuizAttemptStatus.inProgress;
    return QuizAttemptStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => QuizAttemptStatus.submitted,
    );
  }
}

abstract final class QuizQuestionModel {
  static QuizQuestionEntity fromJson(Map<String, dynamic> json) {
    return QuizQuestionEntity(
      id: json['id']?.toString() ?? '',
      questionText: (json['questionText'] ?? json['question_text'] ?? json['text']) as String? ?? '',
      questionImageUrl: (json['questionImageUrl'] ?? json['question_image_url']) as String?,
      questionType: _parseQuestionType(json['questionType'] ?? json['type']),
      options: (json['options'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      marks: (json['marks'] ?? json['points'] as num?)?.toInt() ?? 1,
      negativeMarks: (json['negativeMarks'] ?? json['negative_marks'] as num?)?.toInt() ?? 0,
      explanation: (json['explanation'] ?? json['review_notes']) as String?,
      order: (json['order'] ?? json['orderIndex'] ?? json['order_index'] as num?)?.toInt() ?? 0,
    );
  }

  static QuizQuestionType _parseQuestionType(dynamic value) {
    if (value == null) return QuizQuestionType.multipleChoice;
    final str = value.toString().toLowerCase();
    if (str == 'multiplechoice' || str == 'multiple_choice' || str == 'single') return QuizQuestionType.multipleChoice;
    return QuizQuestionType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => QuizQuestionType.multipleChoice,
    );
  }
}
