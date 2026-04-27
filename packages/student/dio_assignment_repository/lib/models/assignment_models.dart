import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.totalMarks,
    super.questions = const [],
    super.questionsCount,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: DateTime.tryParse(json['deadline'] ?? json['due_date'] ?? '') ??
          DateTime.now(),
      totalMarks: (json['totalMarks'] ?? json['total_marks'] ?? 0).toInt(),
      questionsCount:
          (json['questionsCount'] ?? json['questions_count'] ?? 0).toInt(),
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuizQuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

final class AssignmentSubmissionModel extends AssignmentSubmissionEntity {
  const AssignmentSubmissionModel({
    required super.id,
    required super.assignmentId,
    super.assignmentTitle,
    super.courseName,
    required super.status,
    required super.submittedAt,
    super.answers = const {},
    super.fileUrls = const [],
    super.contentText,
    super.notes,
    super.score,
    super.totalMarks,
    super.feedback,
    super.isLate = false,
    super.gradedAt,
  });

  factory AssignmentSubmissionModel.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmissionModel(
      id: json['id']?.toString() ?? '',
      assignmentId: (json['assignmentId'] ?? json['assignment_id'])?.toString() ?? '',
      assignmentTitle: (json['assignmentTitle'] ?? json['assignment_title'])?.toString(),
      courseName: (json['courseName'] ?? json['course_name'])?.toString(),
      status: SubmissionStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'submitted'),
        orElse: () => SubmissionStatus.submitted,
      ),
      submittedAt: DateTime.tryParse(json['submittedAt'] ?? json['submitted_at'] ?? '') ??
          DateTime.now(),
      answers: (json['answers'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(k, v.toString()),
          ) ??
          const {},
      fileUrls: (json['fileUrls'] ?? json['file_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      contentText: json['contentText'] ?? json['content_text'],
      notes: json['notes'],
      score: (json['score'] ?? json['marks_attained'])?.toInt(),
      totalMarks: (json['totalMarks'] ?? json['total_marks'])?.toInt(),
      feedback: json['feedback'],
      isLate: json['isLate'] ?? json['is_late'] ?? false,
      gradedAt: (json['gradedAt'] ?? json['graded_at']) != null
          ? DateTime.tryParse(json['gradedAt'] ?? json['graded_at'])
          : null,
    );
  }
}
