import 'package:mentorx_core/mentorx_core.dart';

final class AssignmentModel extends AssignmentEntity {
  const AssignmentModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.totalMarks,
    super.allowLateSubmission,
    super.latePenaltyPercent,
    super.attachmentUrls,
    super.allowedFileTypes,
    super.maxFileSizeMb,
    super.maxFiles,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['dueDate'] as String? ?? json['due_date'] as String),
      totalMarks: (json['totalMarks'] ?? json['total_marks'] ?? json['max_score'] as num?)?.toInt() ?? 100,
      allowLateSubmission: json['allowLateSubmission'] as bool? ?? json['allow_late_submission'] as bool? ?? false,
      latePenaltyPercent: (json['latePenaltyPercent'] ?? json['late_penalty_percent'] as num?)?.toInt(),
      attachmentUrls: (json['attachmentUrls'] ?? json['attachment_urls'] ?? json['file_urls'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      allowedFileTypes: (json['allowedFileTypes'] ?? json['allowed_file_types'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      maxFileSizeMb: (json['maxFileSizeMb'] ?? json['max_file_size_mb'] as num?)?.toInt() ?? 10,
      maxFiles: (json['maxFiles'] ?? json['max_files'] as num?)?.toInt() ?? 3,
    );
  }
}

final class AssignmentSubmissionModel extends AssignmentSubmissionEntity {
  const AssignmentSubmissionModel({
    required super.id,
    required super.assignmentId,
    required super.status,
    required super.submittedAt,
    super.fileUrls,
    super.notes,
    super.score,
    super.totalMarks,
    super.feedback,
    super.isLate,
    super.gradedAt,
  });

  factory AssignmentSubmissionModel.fromJson(Map<String, dynamic> json) {
    return AssignmentSubmissionModel(
      id: json['id']?.toString() ?? '',
      assignmentId: json['assignmentId']?.toString() ?? json['assignment_id']?.toString() ?? '',
      status: _parseStatus(json['status']),
      submittedAt: DateTime.parse(json['submittedAt'] as String? ?? json['submitted_at'] as String),
      fileUrls: ((json['fileUrls'] ?? json['file_urls']) as List?)?.map((e) => e.toString()).toList() ?? const [],
      notes: (json['notes'] ?? json['studentNotes'] ?? json['student_notes']) as String?,
      score: json['score'] != null ? (json['score'] as num).toInt() : null,
      totalMarks: (json['totalMarks'] ?? json['total_marks'] as num?)?.toInt(),
      feedback: (json['feedback'] ?? json['teacherFeedback'] ?? json['teacher_feedback']) as String?,
      isLate: json['isLate'] as bool? ?? json['is_late'] as bool? ?? false,
      gradedAt: (json['gradedAt'] ?? json['graded_at']) != null 
          ? DateTime.tryParse((json['gradedAt'] ?? json['graded_at']) as String) 
          : null,
    );
  }

  static SubmissionStatus _parseStatus(dynamic value) {
    if (value == null) return SubmissionStatus.submitted;
    final str = value.toString().toLowerCase();
    if (str == 'resubmit_requested' || str == 'resubmitrequested') return SubmissionStatus.resubmitRequested;
    return SubmissionStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => SubmissionStatus.submitted,
    );
  }
}
