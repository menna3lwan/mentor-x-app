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
  Future<List<QuizQuestionEntity>> getQuizQuestions(String quizId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.questions(quizId);
  }

  @override
  Future<QuizAttemptEntity> submitQuiz(
    String quizId, {
    required Map<String, String> answers,
    String? attemptId,
  }) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(quizId);
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(attemptId);
  }

  @override
  Future<QuizEntity> createQuiz(Map<String, dynamic> data) async {
    await Future<void>.delayed(delay);
    return QuizEntity(
      id: 'new_quiz',
      title: data['title'] ?? 'New Quiz',
      questions: const [],
      durationMinutes: 30,
      totalMarks: 100,
    );
  }

  @override
  Future<(QuizAttemptEntity, List<QuizQuestionEntity>)> startQuiz(String quizId) async {
    await Future<void>.delayed(delay);
    final quizQuestions = await getQuizQuestions(quizId);
    final attempt = QuizAttemptEntity(
      id: 'mock_attempt_id',
      quizId: quizId,
      attemptNumber: 1,
      status: QuizAttemptStatus.inProgress,
      score: 0,
      totalMarks: 100,
      percentage: 0.0,
      passed: false,
      startedAt: DateTime.now(),
    );
    return (attempt, quizQuestions);
  }

  @override
  Future<void> saveAnswer({
    required String attemptId,
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  }) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<QuizAttemptEntity> submitQuizAttempt(String attemptId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult('mock_quiz_id');
  }

  @override
  Future<List<QuizEntity>> getQuizzesByWeek(String weekId) async {
    await Future<void>.delayed(delay);
    return getQuizzes();
  }

  @override
  Future<void> deleteQuiz(String quizId) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<void> deleteAttempt(String attemptId) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<List<QuizAttemptEntity>> getStudentAttempts(String studentId) async {
    await Future<void>.delayed(delay);
    return [MockQuizGenerator.submitResult('attempt_1')];
  }

  @override
  Future<Map<String, dynamic>> getStudentQuizStatus(String studentId) async {
    await Future<void>.delayed(delay);
    return {'status': 'eligible'};
  }

  @override
  Future<QuizAttemptEntity?> getStudentAttemptForQuiz(String studentId, String quizId) async {
    await Future<void>.delayed(delay);
    return MockQuizGenerator.submitResult(quizId);
  }

  @override
  Future<List<QuizAttemptEntity>> getAttemptsForQuiz(String quizId) async {
    await Future<void>.delayed(delay);
    return [MockQuizGenerator.submitResult('attempt_1')];
  }

  @override
  Future<Map<String, dynamic>> getQuizStatistics(String quizId) async {
    await Future<void>.delayed(delay);
    return {'average_score': 85.0};
  }
}
