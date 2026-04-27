part of 'package:mentorx_core/mentorx_core.dart';

enum QuizRepositoryExceptionCode {
  unknown,
  failedToStartQuiz,
  failedToSaveAnswer,
  failedToSubmitQuiz,
  failedToLoadResults,
}

final class QuizRepositoryException
    extends MentorXException<QuizRepositoryExceptionCode> {
  const QuizRepositoryException({required super.code, super.message});
}

abstract interface class QuizRepository {
  Future<void> initialize();

  /// Fetch all available quizzes.
  Future<List<QuizEntity>> getQuizzes();

  /// Fetch quiz details with questions.
  Future<QuizEntity> getQuiz(String quizId);

  /// Submit the quiz with all answers.
  Future<QuizAttemptEntity> submitQuiz(
    String quizId, {
    required Map<String, String> answers,
  });

  /// Fetch detailed quiz results for an attempt.
  Future<QuizAttemptEntity> getResults(String attemptId);
}
