import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockGradeRepository implements GradeRepository {
  final Duration delay;

  const MockGradeRepository({required this.delay});

  @override
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    return MockGradeGenerator.quizGrades();
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    return MockGradeGenerator.assignmentGrades();
  }
}
