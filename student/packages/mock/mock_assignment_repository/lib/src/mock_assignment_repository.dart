import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';
import 'package:student_core/student_core.dart';

final class MockAssignmentRepository implements AssignmentRepository {
  final Duration delay;

  const MockAssignmentRepository({required this.delay});

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
  Future<List<String>> uploadFiles(List<String> localFilePaths) async {
    await Future<void>.delayed(delay);
    return localFilePaths
        .map(
          (path) =>
              'https://storage.example.com/uploads/${path.split('/').last}',
        )
        .toList();
  }

  @override
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    required List<String> fileUrls,
    String? notes,
  }) async {
    await Future<void>.delayed(delay);
    return AssignmentSubmissionEntity(
      id: 'sub-1',
      assignmentId: assignmentId,
      fileUrls: fileUrls,
      notes: notes,
      status: SubmissionStatus.submitted,
      submittedAt: DateTime.now(),
    );
  }
}
