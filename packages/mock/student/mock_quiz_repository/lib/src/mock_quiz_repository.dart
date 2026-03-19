import 'dart:async';

import 'package:mock_data/mock_data.dart';
import 'package:student_core/student_core.dart';

final class MockQuizRepository implements QuizRepository {
  final Duration delay;

  const MockQuizRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<({QuizAttemptEntity attempt, List<QuizQuestionEntity> questions})>
  startQuiz(String quizId) async {
    await Future<void>.delayed(delay);
    final attempt = MockQuizGenerator.startAttempt(quizId);
    final questions = MockQuizGenerator.questions(quizId);
    return (attempt: attempt, questions: questions);
  }

  @override
  Future<void> saveAnswer(
    String attemptId, {
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  }) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<QuizAttemptEntity> submitQuiz(String attemptId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(attemptId);
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(attemptId);
  }
}
