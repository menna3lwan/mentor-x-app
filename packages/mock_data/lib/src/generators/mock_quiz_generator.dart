part of '../../mock_data.dart';

final class MockQuizGenerator {
  MockQuizGenerator._();

  static List<QuizEntity> quizList() {
    final now = DateTime.now();
    return [
      QuizEntity(
        id: 'q1',
        title: 'Algebra Midterm Quiz',
        durationMinutes: 30,
        totalMarks: 50,
        active: true,
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      QuizEntity(
        id: 'q2',
        title: 'Physics — Laws of Motion',
        durationMinutes: 45,
        totalMarks: 80,
        active: true,
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      const QuizEntity(
        id: 'q3',
        title: 'Chemistry Elements Quiz',
        durationMinutes: 20,
        totalMarks: 30,
      ),
      const QuizEntity(
        id: 'q4',
        title: 'English Grammar Test',
        durationMinutes: 25,
        totalMarks: 40,
      ),
      QuizEntity(
        id: 'q5',
        title: 'Biology Cell Division',
        durationMinutes: 35,
        totalMarks: 60,
        active: true,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  static List<QuizQuestionEntity> questions(String quizId) {
    return const [
      QuizQuestionEntity(
        id: 'qq1',
        type: QuizQuestionType.multipleChoice,
        text: 'What is the value of x in 2x + 5 = 15?',
        options: ['x = 3', 'x = 5', 'x = 7', 'x = 10'],
        mark: 10,
        order: 0,
      ),
      QuizQuestionEntity(
        id: 'qq2',
        type: QuizQuestionType.trueFalse,
        text: 'Is the equation x² = -1 solvable in real numbers?',
        options: ['True', 'False'],
        mark: 5,
        order: 1,
      ),
      QuizQuestionEntity(
        id: 'qq3',
        type: QuizQuestionType.shortAnswer,
        text: 'The quadratic formula is x = (-b ± √(b²-4ac)) / ___',
        mark: 10,
        order: 2,
      ),
      QuizQuestionEntity(
        id: 'qq4',
        type: QuizQuestionType.multipleChoice,
        text: 'Which of the following are prime numbers?',
        options: ['2', '4', '7', '9', '11'],
        mark: 15,
        order: 3,
      ),
      QuizQuestionEntity(
        id: 'qq5',
        type: QuizQuestionType.essay,
        text:
            'Explain the difference between a linear and quadratic equation.',
        mark: 10,
        order: 4,
      ),
    ];
  }

  static QuizAttemptEntity startAttempt(String quizId) {
    return QuizAttemptEntity(
      id: 'attempt_${DateTime.now().millisecondsSinceEpoch}',
      quizId: quizId,
      attemptNumber: 1,
      status: QuizAttemptStatus.inProgress,
      score: 0,
      totalMarks: 50,
      percentage: 0.0,
      passed: false,
      startedAt: DateTime.now(),
    );
  }

  static QuizAttemptEntity submitResult(String attemptId) {
    return QuizAttemptEntity(
      id: attemptId,
      quizId: 'q1',
      attemptNumber: 1,
      status: QuizAttemptStatus.submitted,
      score: 38,
      totalMarks: 50,
      percentage: 76.0,
      passed: true,
      startedAt: DateTime.now().subtract(const Duration(minutes: 25)),
      submittedAt: DateTime.now(),
      timeSpentSeconds: 1500,
    );
  }
}
