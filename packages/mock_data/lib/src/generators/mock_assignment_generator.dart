import 'package:mentorx_core/mentorx_core.dart';

final class MockAssignmentGenerator {
  MockAssignmentGenerator._();

  static AssignmentEntity assignment(String assignmentId) {
    return AssignmentEntity(
      id: assignmentId,
      title: 'Linear Equations Problem Set',
      description:
          'Solve the following 10 problems involving linear equations in two variables. Show your work for each solution.',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      totalMarks: 100,
      allowLateSubmission: true,
      latePenaltyPercent: 10,
      allowedFileTypes: const ['pdf', 'jpg', 'png'],
      maxFileSizeMb: 10,
      maxFiles: 5,
    );
  }

  static AssignmentSubmissionEntity? submission(String assignmentId) {
    return AssignmentSubmissionEntity(
      id: 'sub1',
      assignmentId: assignmentId,
      fileUrls: const ['https://example.com/uploads/assignment1.pdf'],
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
