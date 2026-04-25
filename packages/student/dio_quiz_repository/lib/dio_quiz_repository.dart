import 'package:mentorx_core/mentorx_core.dart';
import 'models/quiz_models.dart';
export 'models/quiz_models.dart';

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
    try {
      final response = await httpClient.post('/api/quizzes/$quizId/start');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final attempt = QuizAttemptModel.fromJson(asMap(data['attempt']));
      final questions = asList(data['questions'] ??
              asMap(response.data)['content'] ??
              asMap(response.data)['data'] ??
              response.data)
          .map((e) => QuizQuestionModel.fromJson(asMap(e)))
          .toList();

      return (attempt: attempt, questions: questions);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToStartQuiz,
      );
    }
  }

  @override
  Future<void> saveAnswer(
    String attemptId, {
    required String questionId,
    List<String>? selectedOptions,
    String? textAnswer,
  }) async {
    try {
      await httpClient.post(
        '/api/quiz-attempts/$attemptId/answers',
        data: {
          'question_id': questionId,
          if (selectedOptions != null) 'selected_options': selectedOptions,
          if (textAnswer != null) 'text_answer': textAnswer,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToSaveAnswer,
      );
    }
  }

  @override
  Future<QuizAttemptEntity> submitQuiz(String attemptId) async {
    try {
      final response = await httpClient.post('/api/quiz-attempts/$attemptId/submit');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToSubmitQuiz,
      );
    }
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    try {
      final response = await httpClient.get('/api/quiz-attempts/$attemptId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToLoadResults,
      );
    }
  }

}
