import 'dart:async';

import 'package:mock_data/mock_data.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class MockAssignmentRepository implements AssignmentRepository {
  final Duration delay;

  const MockAssignmentRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<AssignmentEntity> getAssignment(String assignmentId) async {
    await Future<void>.delayed(delay);
    return MockAssignmentGenerator.assignment(assignmentId);
  }

  @override
  Future<AssignmentSubmissionEntity?> getSubmission(
    String assignmentId,
  ) async {
    await Future<void>.delayed(delay);
    return MockAssignmentGenerator.submission(assignmentId);
  }

  @override
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    Map<String, String> answers = const {},
    List<String> filePaths = const [],
    String? contentText,
  }) async {
    await Future<void>.delayed(delay);
    return AssignmentSubmissionEntity(
      id: 'sub-1',
      assignmentId: assignmentId,
      answers: answers,
      fileUrls: filePaths,
      contentText: contentText,
      status: SubmissionStatus.submitted,
      submittedAt: DateTime.now(),
    );
  }

  @override
  Future<void> deleteAttempt(String attemptId) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getStudentAttempts(String studentId) async {
    await Future<void>.delayed(delay);
    return [MockAssignmentGenerator.submission('assignment_1')!];
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAttemptsForAssignment(String assignmentId) async {
    await Future<void>.delayed(delay);
    return [MockAssignmentGenerator.submission(assignmentId)!];
  }

  @override
  Future<Map<String, dynamic>> getAssignmentStatistics(String assignmentId) async {
    await Future<void>.delayed(delay);
    return {'average_score': 90.0};
  }
}
