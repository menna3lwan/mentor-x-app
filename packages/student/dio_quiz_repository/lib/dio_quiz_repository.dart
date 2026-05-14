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
      return response.asList().map((e) => QuizModel.fromJson(asMap(e))).toList();
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
      return QuizModel.fromJson(response.asMap());
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
      return response.asList().map((e) => QuizQuestionModel.fromJson(asMap(e))).toList();
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

      return QuizAttemptModel.fromJson(response.asMap());
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.failedToSubmitQuiz,
      );
    }
  }

  @override
  Future<(QuizAttemptEntity, List<QuizQuestionEntity>)> startQuiz(
    String quizId,
  ) async {
    try {
      final response = await httpClient.post('/api/quizzes/$quizId/start');
      final data = response.asMap();

      final attempt = QuizAttemptModel.fromJson(asMap(data['attempt']));
      final questions = asList(data['questions'])
          .map((e) => QuizQuestionModel.fromJson(asMap(e)))
          .toList();

      return (attempt, questions);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        codeFromStatusCode: (status) => status == 409
            ? QuizRepositoryExceptionCode.quizAlreadyStarted
            : QuizRepositoryExceptionCode.failedToStartQuiz,
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
      await httpClient.put(
        '/api/quiz-attempts/$attemptId/answer',
        data: {
          'questionId': questionId,
          'question_id': questionId,
          'selectedOptions': selectedOptions ?? (textAnswer != null ? [textAnswer] : []),
          'selected_options': selectedOptions ?? (textAnswer != null ? [textAnswer] : []),
          'textAnswer': textAnswer,
          'text_answer': textAnswer,
          'time_spent_seconds': 0, // Default to 0, can be extended later
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
      final response = await httpClient.post(
        '/api/quiz-attempts/$attemptId/submit',
        data: {
          'submit_type': 'manual',
          'submitType': 'manual',
          'total_time_spent_seconds': 0,
        },
      );
      return QuizAttemptModel.fromJson(response.asMap());
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
      return QuizAttemptModel.fromJson(response.asMap());
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
      return QuizModel.fromJson(response.asMap());
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
      return response.asList().map((e) => QuizModel.fromJson(asMap(e))).toList();
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
      final response = await httpClient.get('/api/quiz-attempts/student/$studentId');
      return response.asList().map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
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
      final response = await httpClient.get('/api/quiz-attempts/student/$studentId/status');
      return response.asMap();
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
      final response = await httpClient.get('/api/quiz-attempts/student/$studentId/quiz/$quizId');
      return QuizAttemptModel.fromJson(response.asMap());
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
      return response.asList().map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
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
      final response = await httpClient.get('/api/quiz-attempts/quiz/$quizId/statistics');
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: QuizRepositoryExceptionCode.unknown,
      );
    }
  }
}
