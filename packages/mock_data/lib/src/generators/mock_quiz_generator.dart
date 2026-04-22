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
        maxAttempts: 2,
        passPercentage: 60,
        shuffleQuestions: true,
        shuffleOptions: true,
        showCorrectAnswers: true,
        showExplanations: true,
        showScoreImmediately: true,
        availableFrom: now.subtract(const Duration(days: 7)),
        availableUntil: now.add(const Duration(days: 7)),
      ),
      QuizEntity(
        id: 'q2',
        title: 'Physics — Laws of Motion',
        durationMinutes: 45,
        totalMarks: 80,
        maxAttempts: 1,
        passPercentage: 50,
        shuffleQuestions: false,
        shuffleOptions: true,
        showCorrectAnswers: false,
        showExplanations: false,
        showScoreImmediately: true,
        availableFrom: now.subtract(const Duration(days: 3)),
        availableUntil: now.add(const Duration(days: 10)),
      ),
      const QuizEntity(
        id: 'q3',
        title: 'Chemistry Elements Quiz',
        durationMinutes: 20,
        totalMarks: 30,
        maxAttempts: 3,
        passPercentage: 70,
        shuffleQuestions: true,
        shuffleOptions: true,
        showCorrectAnswers: true,
        showExplanations: true,
        showScoreImmediately: true,
      ),
      const QuizEntity(
        id: 'q4',
        title: 'English Grammar Test',
        durationMinutes: 25,
        totalMarks: 40,
        maxAttempts: 2,
        passPercentage: 60,
        shuffleQuestions: true,
        shuffleOptions: true,
        showCorrectAnswers: true,
        showExplanations: true,
        showScoreImmediately: true,
      ),
      QuizEntity(
        id: 'q5',
        title: 'Biology Cell Division',
        durationMinutes: 35,
        totalMarks: 60,
        maxAttempts: 1,
        passPercentage: 50,
        shuffleQuestions: false,
        shuffleOptions: false,
        showCorrectAnswers: true,
        showExplanations: true,
        showScoreImmediately: false,
        availableFrom: now.subtract(const Duration(days: 1)),
        availableUntil: now.add(const Duration(days: 14)),
      ),
    ];
  }

  static List<QuizQuestionEntity> questions(String quizId) {
    return const [
      QuizQuestionEntity(
        id: 'qq1',
        questionText: 'What is the value of x in 2x + 5 = 15?',
        questionType: QuizQuestionType.multipleChoice,
        options: ['x = 3', 'x = 5', 'x = 7', 'x = 10'],
        marks: 10,
        explanation: '2x + 5 = 15 → 2x = 10 → x = 5',
        order: 0,
      ),
      QuizQuestionEntity(
        id: 'qq2',
        questionText: 'Is the equation x² = -1 solvable in real numbers?',
        questionType: QuizQuestionType.trueFalse,
        options: ['True', 'False'],
        marks: 5,
        explanation:
            'x² = -1 has no real solution; solutions exist in complex numbers.',
        order: 1,
      ),
      QuizQuestionEntity(
        id: 'qq3',
        questionText: 'The quadratic formula is x = (-b ± √(b²-4ac)) / ___',
        questionType: QuizQuestionType.fillInTheBlank,
        marks: 10,
        explanation: 'The denominator of the quadratic formula is 2a.',
        order: 2,
      ),
      QuizQuestionEntity(
        id: 'qq4',
        questionText: 'Which of the following are prime numbers?',
        questionType: QuizQuestionType.multipleChoice,
        options: ['2', '4', '7', '9', '11'],
        marks: 15,
        explanation: '2, 7, and 11 are prime numbers.',
        order: 3,
      ),
      QuizQuestionEntity(
        id: 'qq5',
        questionText:
            'Explain the difference between a linear and quadratic equation.',
        questionType: QuizQuestionType.essay,
        marks: 10,
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
