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

  Future<QuizEntity> getQuiz(String quizId);

  /// Fetch quiz questions.
  Future<List<QuizQuestionEntity>> getQuizQuestions(String quizId);

  /// Submit the quiz with all answers.
  /// Deprecated: use submitQuizAttempt instead if the backend supports it.
  Future<QuizAttemptEntity> submitQuiz(
    String quizId, {
    required Map<String, String> answers,
  });

  /// Start a new quiz attempt. Returns the attempt and questions.
  Future<Map<String, dynamic>> startQuiz(String quizId);

  /// Save a quiz answer during an attempt.
  Future<void> saveAnswer({
    required String attemptId,
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  });

  /// Submit the quiz attempt.
  Future<QuizAttemptEntity> submitQuizAttempt(String attemptId);

  /// Fetch detailed quiz results for an attempt.
  Future<QuizAttemptEntity> getResults(String attemptId);

  // Pro Features
  Future<QuizEntity> createQuiz(Map<String, dynamic> data);
  Future<List<QuizEntity>> getQuizzesByWeek(String weekId);
  Future<void> deleteQuiz(String quizId);
  Future<void> deleteAttempt(String attemptId);
  Future<List<QuizAttemptEntity>> getStudentAttempts(String studentId);
  Future<Map<String, dynamic>> getStudentQuizStatus(String studentId);
  Future<QuizAttemptEntity?> getStudentAttemptForQuiz(String studentId, String quizId);
  Future<List<QuizAttemptEntity>> getAttemptsForQuiz(String quizId);
  Future<Map<String, dynamic>> getQuizStatistics(String quizId);
}
