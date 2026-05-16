import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockGradeRepository implements GradeRepository {
  final Duration delay;

  const MockGradeRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockGradeGenerator.quizGrades();
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockGradeGenerator.assignmentGrades();
  }

  @override
  Future<List<GradeEntity>> getLevels() async {
    await Future<void>.delayed(delay);
    return const [
      GradeEntity(id: 'l1', name: 'Level 1'),
      GradeEntity(id: 'l2', name: 'Level 2'),
    ];
  }
}
