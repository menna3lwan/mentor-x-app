import 'dart:async';

import 'package:mock_data/mock_data.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class MockQuizRepository implements QuizRepository {
  final Duration delay;

  const MockQuizRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<QuizEntity>> getQuizzes() async {
    await Future<void>.delayed(delay);
    return List.generate(
      5,
      (index) => QuizEntity(
        id: 'q_$index',
        title: 'Mock Quiz $index',
        questions: const [],
        durationMinutes: 30,
        totalMarks: 100,
      ),
    );
  }

  @override
  Future<QuizEntity> getQuiz(String quizId) async {
    await Future<void>.delayed(delay);
    final questions = MockQuizGenerator.questions(quizId);
    return QuizEntity(
      id: quizId,
      title: 'Mock Quiz $quizId',
      questions: questions,
      durationMinutes: 30,
      totalMarks: 100,
    );
  }

  @override
  Future<QuizAttemptEntity> submitQuiz(
    String quizId, {
    required Map<String, String> answers,
  }) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(quizId);
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(attemptId);
  }
}
