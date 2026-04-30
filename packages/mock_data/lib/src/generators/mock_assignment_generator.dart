part of '../../mock_data.dart';

final class MockAssignmentGenerator {
  MockAssignmentGenerator._();

  static AssignmentEntity assignment(String assignmentId) {
    return AssignmentEntity(
      id: assignmentId,
      title: 'Linear Equations Problem Set',
      description:
          'Solve the following 10 problems involving linear equations in two variables. Show your work for each solution.',
      deadline: DateTime.now().add(const Duration(days: 3)),
      totalMarks: 100,
    );
  }

  static AssignmentSubmissionEntity? submission(String assignmentId) {
    return AssignmentSubmissionEntity(
      id: 'sub1',
      assignmentId: assignmentId,
      answers: const {'q1': 'https://example.com/uploads/assignment1.pdf'},
      notes: 'Completed all problems. Some work shown on paper.',
      score: 85,
      totalMarks: 100,
      feedback: 'Good work! Review problem 7 — the sign was flipped.',
      status: SubmissionStatus.graded,
      isLate: false,
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      gradedAt: DateTime.now().subtract(const Duration(hours: 6)),
    );
  }
}
