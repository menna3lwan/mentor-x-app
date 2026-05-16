import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    super.description,
    super.deadline,
    super.totalMarks = 0,
    super.questions = const [],
    super.questionsCount,
    super.active = true,
    super.deleted = false,
    super.weekId,
    super.courseId,
    super.createdAt,
    super.updatedAt,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      deadline: ModelParser.asDateTime(json['deadline'] ?? json['due_date']),
      totalMarks: ModelParser.asInt(json['totalMarks'] ?? json['total_marks']),
      questionsCount: ModelParser.asInt(
        json['questionsCount'] ?? json['questions_count'],
      ),
      questions: ModelParser.asList(
        json['questions'],
      ).map((e) => QuizQuestionModel.fromJson(ModelParser.asMap(e))).toList(),
      active: ModelParser.asBool(json['active'], fallback: true),
      deleted: ModelParser.asBool(json['deleted']),
      weekId: ModelParser.asString(json['weekId'] ?? json['week_id']),
      courseId: ModelParser.asString(json['courseId'] ?? json['course_id']),
      createdAt: ModelParser.asDateTime(
        json['createdAt'] ?? json['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        json['updatedAt'] ?? json['updated_at'],
      ),
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
      id: ModelParser.asString(json['attemptId'] ?? json['id']),
      assignmentId: ModelParser.asString(
        json['assignmentId'] ?? json['assignment_id'],
      ),
      assignmentTitle: ModelParser.asString(
        json['assignmentTitle'] ?? json['assignment_title'],
      ),
      courseName: ModelParser.asString(
        json['courseName'] ?? json['course_name'],
      ),
      status: _parseStatus(
        json['status'] ??
            (ModelParser.asBool(json['submitted']) ? 'submitted' : 'pending'),
      ),
      submittedAt:
          ModelParser.asDateTime(json['submittedAt'] ?? json['submitted_at']) ??
          DateTime.now(),
      answers: ModelParser.asMap(json['answers']).map(
        (k, v) => MapEntry(k, v.toString()),
      ),
      fileUrls: ModelParser.asList(
        json['fileUrls'] ?? json['file_urls'],
      ).map((e) => e.toString()).toList(),
      contentText: ModelParser.asString(
        json['contentText'] ?? json['content_text'],
      ),
      notes: ModelParser.asString(json['notes']),
      score: ModelParser.asInt(json['score'] ?? json['marks_attained']),
      totalMarks: ModelParser.asInt(json['totalMarks'] ?? json['total_marks']),
      feedback: ModelParser.asString(json['feedback']),
      isLate: ModelParser.asBool(json['isLate'] ?? json['is_late']),
      gradedAt: ModelParser.asDateTime(json['gradedAt'] ?? json['graded_at']),
    );
  }

  static SubmissionStatus _parseStatus(String? status) {
    return switch (status?.toLowerCase()) {
      'submitted' => SubmissionStatus.submitted,
      'graded' => SubmissionStatus.graded,
      'late' => SubmissionStatus.late,
      'rejected' => SubmissionStatus.rejected,
      _ => SubmissionStatus.pending,
    };
  }
}
