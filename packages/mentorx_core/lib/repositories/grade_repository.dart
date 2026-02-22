part of '../mentorx_core.dart';

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
  /// Fetch all assessment grades across courses.
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  });

  /// Fetch assignment submission results.
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  });
}
