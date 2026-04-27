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
  Future<List<QuizEntity>> getQuizzes() async {
    try {
      final response = await httpClient.get('/api/quizzes');
      final data = asList(response.data);
      return data.map((e) => QuizModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<QuizEntity> getQuiz(String quizId) async {
    try {
      final response = await httpClient.get('/api/quizzes/$quizId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToStartQuiz,
      );
    }
  }


  @override
  Future<QuizAttemptEntity> submitQuiz(
    String quizId, {
    required Map<String, String> answers,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/quizzes/$quizId/submit',
        data: {
          'quizId': quizId,
          'answers': answers.entries
              .map((e) => {
                    'questionId': e.key,
                    'selectedAnswer': e.value,
                  })
              .toList(),
        },
      );

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
  Future<QuizAttemptModel> getResults(String attemptId) async {
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
