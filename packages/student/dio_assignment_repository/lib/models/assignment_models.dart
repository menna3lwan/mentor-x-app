import 'package:mentorx_core/mentorx_core.dart';

final class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.totalMarks,
    super.allowLateSubmission = false,
    super.latePenaltyPercent,
    super.attachmentUrls = const [],
    super.allowedFileTypes = const [],
    super.maxFileSizeMb = 10,
    super.maxFiles = 3,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: DateTime.tryParse(json['due_date'] ?? '') ?? DateTime.now(),
      totalMarks: (json['total_marks'] ?? 0).toInt(),
      allowLateSubmission: json['allow_late_submission'] ?? false,
      latePenaltyPercent: json['late_penalty_percent']?.toInt(),
      attachmentUrls: (json['attachment_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      allowedFileTypes: (json['allowed_file_types'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      maxFileSizeMb: (json['max_file_size_mb'] ?? 10).toInt(),
      maxFiles: (json['max_files'] ?? 3).toInt(),
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
    super.fileUrls = const [],
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
      assignmentId: json['assignment_id']?.toString() ?? '',
      assignmentTitle: json['assignment_title']?.toString(),
      courseName: json['course_name']?.toString(),
      status: SubmissionStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'submitted'),
        orElse: () => SubmissionStatus.submitted,
      ),
      submittedAt:
          DateTime.tryParse(json['submitted_at'] ?? '') ?? DateTime.now(),
      fileUrls: (json['file_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      notes: json['notes'],
      score: json['score']?.toInt(),
      totalMarks: json['total_marks']?.toInt(),
      feedback: json['feedback'],
      isLate: json['is_late'] ?? false,
      gradedAt:
          json['graded_at'] != null ? DateTime.tryParse(json['graded_at']) : null,
    );
  }
}
