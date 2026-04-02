part of '../../mentorx_core.dart';

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

  /// Fetch the student's submission for an assignment.
  Future<AssignmentSubmissionEntity?> getSubmission(String assignmentId);

  /// Upload assignment files and return the file URLs.
  Future<List<String>> uploadFiles(List<String> localFilePaths);

  /// Submit an assignment.
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    required List<String> fileUrls,
    String? notes,
  });
}
