part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentGradeRepositoryExceptionCode {
  unknown,
  fetchError,
}

final class ParentGradeRepositoryException
    extends MentorXException<ParentGradeRepositoryExceptionCode> {
  const ParentGradeRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentGradeRepository {
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId);
  Future<ParentGradeTrendEntity> getGradeTrend(String childId, {int months = 6});
  Future<List<QuizAttemptEntity>> getAssessments(
    String childId, {
    String? type,
    String? courseId,
  });
}
