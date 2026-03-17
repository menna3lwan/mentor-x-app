import 'package:mentorx_core/mentorx_core.dart';

final class MockGradeGenerator {
  MockGradeGenerator._();

  static List<QuizAttemptEntity> quizGrades() {
    final now = DateTime.now();
    return [
      QuizAttemptEntity(
        id: 'qa1',
        quizId: 'quiz_algebra_1',
        attemptNumber: 1,
        status: QuizAttemptStatus.submitted,
        score: 18,
        totalMarks: 20,
        percentage: 90.0,
        passed: true,
        startedAt: now.subtract(const Duration(days: 2, hours: 1)),
        submittedAt: now.subtract(const Duration(days: 2)),
        timeSpentSeconds: 1800,
      ),
      QuizAttemptEntity(
        id: 'qa2',
        quizId: 'quiz_history_1',
        attemptNumber: 1,
        status: QuizAttemptStatus.submitted,
        score: 14,
        totalMarks: 20,
        percentage: 70.0,
        passed: true,
        startedAt: now.subtract(const Duration(days: 5, hours: 1)),
        submittedAt: now.subtract(const Duration(days: 5)),
        timeSpentSeconds: 1500,
      ),
      QuizAttemptEntity(
        id: 'qa3',
        quizId: 'quiz_physics_1',
        attemptNumber: 2,
        status: QuizAttemptStatus.submitted,
        score: 9,
        totalMarks: 20,
        percentage: 45.0,
        passed: false,
        startedAt: now.subtract(const Duration(days: 8, hours: 1)),
        submittedAt: now.subtract(const Duration(days: 8)),
        timeSpentSeconds: 2100,
      ),
    ];
  }

  static List<AssignmentSubmissionEntity> assignmentGrades() {
    final now = DateTime.now();
    return [
      AssignmentSubmissionEntity(
        id: 'as1',
        assignmentId: 'asgn_essay_1',
        status: SubmissionStatus.graded,
        score: 85,
        totalMarks: 100,
        feedback: 'Well written essay. Great structure and references.',
        submittedAt: now.subtract(const Duration(days: 3)),
        gradedAt: now.subtract(const Duration(days: 2)),
      ),
      AssignmentSubmissionEntity(
        id: 'as2',
        assignmentId: 'asgn_math_1',
        status: SubmissionStatus.graded,
        score: 72,
        totalMarks: 100,
        feedback: 'Good effort. Work on showing your steps clearly.',
        submittedAt: now.subtract(const Duration(days: 7)),
        gradedAt: now.subtract(const Duration(days: 6)),
      ),
    ];
  }
}
