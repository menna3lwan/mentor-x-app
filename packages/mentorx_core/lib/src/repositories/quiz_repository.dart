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

  /// Start a quiz attempt and receive questions.
  Future<({QuizAttemptEntity attempt, List<QuizQuestionEntity> questions})>
  startQuiz(String quizId);

  /// Save an answer for a question in an active attempt.
  Future<void> saveAnswer(
    String attemptId, {
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  });

  /// Submit the entire quiz attempt.
  Future<QuizAttemptEntity> submitQuiz(String attemptId);

  /// Fetch detailed quiz results.
  Future<QuizAttemptEntity> getResults(String attemptId);
}
