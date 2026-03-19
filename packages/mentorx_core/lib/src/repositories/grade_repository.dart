part of '../../mentorx_core.dart';

enum GradeRepositoryExceptionCode {
  unknown,
  failedToLoadGrades,
  failedToLoadCourseGrades,
  failedToLoadQuizResults,
  failedToLoadAssignmentResults,
}

final class GradeRepositoryException
    extends MentorXException<GradeRepositoryExceptionCode> {
  GradeRepositoryException({required super.code, super.message});
}

abstract interface class GradeRepository {
  Future<void> initialize();

  /// Fetch all assessment grades across courses.
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch assignment submission results.
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  });
}
