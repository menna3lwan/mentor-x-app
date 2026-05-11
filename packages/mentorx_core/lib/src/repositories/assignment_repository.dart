part of 'package:mentorx_core/mentorx_core.dart';

enum AssignmentRepositoryExceptionCode {
  unknown,
  failedToLoadAssignment,
  failedToLoadSubmission,
  failedToUploadFiles,
  failedToSubmitAssignment,
}

final class AssignmentRepositoryException
    extends MentorXException<AssignmentRepositoryExceptionCode> {
  const AssignmentRepositoryException({required super.code, super.message});
}

abstract interface class AssignmentRepository {
  Future<void> initialize();

  /// Fetch assignment details.
  Future<AssignmentEntity> getAssignment(String assignmentId);

  /// Fetch all assignments for the student.
  Future<List<AssignmentEntity>> getAssignments();

  /// Fetch assignment questions.
  Future<List<QuizQuestionEntity>> getAssignmentQuestions(String assignmentId);

  /// Fetch the student's submission for an assignment.
  Future<AssignmentSubmissionEntity?> getSubmission(String assignmentId);

  /// Submit an assignment.
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    Map<String, String> answers = const {},
    List<String> filePaths = const [],
    String? contentText,
  });

  // Pro Features
  Future<void> deleteAttempt(String attemptId);
  Future<List<AssignmentSubmissionEntity>> getStudentAttempts(String studentId);
  Future<List<AssignmentSubmissionEntity>> getAttemptsForAssignment(String assignmentId);
  Future<Map<String, dynamic>> getAssignmentStatistics(String assignmentId);
}
