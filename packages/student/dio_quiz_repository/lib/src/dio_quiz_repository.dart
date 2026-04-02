import 'package:mentorx_core/mentorx_core.dart';
import '../models/quiz_models.dart';

final class DioQuizRepository
    extends HttpClientRepository<QuizRepositoryExceptionCode>
    implements QuizRepository {
  @override
  Never throwException(QuizRepositoryExceptionCode code, {String? message}) =>
      throw QuizRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioQuizRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<({QuizAttemptEntity attempt, List<QuizQuestionEntity> questions})>
  startQuiz(String quizId) async {
    final response = await httpClient.post('/api/quizzes/$quizId/start');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw QuizRepositoryException(
        code: QuizRepositoryExceptionCode.failedToStartQuiz,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    final attempt = QuizAttemptModel.fromJson(data['attempt']);
    final questions = (data['questions'] as List)
        .map((e) => QuizQuestionModel.fromJson(e))
        .toList();

    return (attempt: attempt, questions: questions);
  }

  @override
  Future<void> saveAnswer(
    String attemptId, {
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  }) async {
    final response = await httpClient.post(
      '/api/quiz-attempts/$attemptId/answers',
      data: {
        'question_id': questionId,
        if (selectedOptions != null) 'selected_options': selectedOptions,
        if (textAnswer != null) 'text_answer': textAnswer,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw QuizRepositoryException(
        code: QuizRepositoryExceptionCode.failedToSaveAnswer,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<QuizAttemptEntity> submitQuiz(String attemptId) async {
    final response = await httpClient.post('/api/quiz-attempts/$attemptId/submit');

    if (response.statusCode != 200) {
      throw QuizRepositoryException(
        code: QuizRepositoryExceptionCode.failedToSubmitQuiz,
        message: response.exception?.message,
      );
    }

    return QuizAttemptModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    final response = await httpClient.get('/api/quiz-attempts/$attemptId/results');

    if (response.statusCode != 200) {
      throw QuizRepositoryException(
        code: QuizRepositoryExceptionCode.failedToLoadResults,
        message: response.exception?.message,
      );
    }

    return QuizAttemptModel.fromJson(response.data['data'] ?? response.data);
  }
}
