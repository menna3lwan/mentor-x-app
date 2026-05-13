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
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => QuizModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToStartQuiz,
      );
    }
  }

  @override
  Future<List<QuizQuestionEntity>> getQuizQuestions(String quizId) async {
    try {
      final response = await httpClient.get('/api/questions/quiz/$quizId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => QuizQuestionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
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
              .map(
                (e) => {
                  'questionId': e.key,
                  'selectedAnswer': e.value,
                },
              )
              .toList(),
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToSubmitQuiz,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> startQuiz(String quizId) async {
    try {
      final response = await httpClient.post('/api/quizzes/$quizId/start');
      return asMap(response.data)['data'] ?? asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToStartQuiz,
      );
    }
  }

  @override
  Future<void> saveAnswer({
    required String attemptId,
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
  Future<QuizAttemptEntity> submitQuizAttempt(String attemptId) async {
    try {
      final response = await httpClient.post('/api/quiz-attempts/$attemptId/submit');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToSubmitQuiz,
      );
    }
  }

  @override
  Future<QuizAttemptEntity> getResults(String attemptId) async {
    try {
      final response = await httpClient.get('/api/quiz-attempts/$attemptId/results');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToLoadResults,
      );
    }
  }

  @override
  Future<QuizEntity> createQuiz(Map<String, dynamic> data) async {
    try {
      final response = await httpClient.post('/api/quizzes', data: data);
      final responseData = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizModel.fromJson(responseData);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<QuizEntity>> getQuizzesByWeek(String weekId) async {
    try {
      final response = await httpClient.get('/api/quizzes/week/$weekId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => QuizModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> deleteQuiz(String quizId) async {
    try {
      await httpClient.delete('/api/quizzes/$quizId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> deleteAttempt(String attemptId) async {
    try {
      await httpClient.delete('/api/quiz-attempts/$attemptId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<QuizAttemptEntity>> getStudentAttempts(String studentId) async {
    try {
      final response = await httpClient.get(
        '/api/quiz-attempts/student/$studentId',
      );
      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getStudentQuizStatus(String studentId) async {
    try {
      final response = await httpClient.get(
        '/api/quiz-attempts/student/$studentId/status',
      );
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<QuizAttemptEntity?> getStudentAttemptForQuiz(
    String studentId,
    String quizId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/quiz-attempts/student/$studentId/quiz/$quizId',
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return QuizAttemptModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<QuizAttemptEntity>> getAttemptsForQuiz(String quizId) async {
    try {
      final response = await httpClient.get('/api/quiz-attempts/quiz/$quizId');
      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getQuizStatistics(String quizId) async {
    try {
      final response = await httpClient.get(
        '/api/quiz-attempts/quiz/$quizId/statistics',
      );
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }
}
