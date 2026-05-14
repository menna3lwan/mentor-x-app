import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'models/assignment_models.dart';
export 'models/assignment_models.dart';

final class DioAssignmentRepository
    extends HttpClientRepository<AssignmentRepositoryExceptionCode>
    implements AssignmentRepository {
  @override
  Never throwException(
    AssignmentRepositoryExceptionCode code, {
    String? message,
  }) => throw AssignmentRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAssignmentRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<AssignmentEntity> getAssignment(String assignmentId) async {
    try {
      final response = await httpClient.get('/api/assignments/$assignmentId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AssignmentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToLoadAssignment,
      );
    }
  }

  @override
  Future<List<AssignmentEntity>> getAssignments() async {
    try {
      final response = await httpClient.get('/api/assignments');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => AssignmentModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToLoadAssignment,
      );
    }
  }

  @override
  Future<List<QuizQuestionEntity>> getAssignmentQuestions(
    String assignmentId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/assignment-questions/assignment/$assignmentId',
      );
      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => QuizQuestionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<AssignmentSubmissionEntity?> getSubmission(String assignmentId) async {
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.get(
          '/api/assignment-attempts/student/me/assignment/$assignmentId',
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await httpClient.get(
          '/api/assignment-attempts/student/me/assignment/$assignmentId',
        );
      }
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AssignmentSubmissionModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToLoadSubmission,
      );
    }
  }

  @override
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    Map<String, String> answers = const {},
    List<String> filePaths = const [],
    String? contentText,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/assignments/$assignmentId/submit',
        data: {
          'assignmentId': assignmentId,
          'assignment_id': assignmentId,
          'answers': answers.entries
              .map(
                (e) => {
                  'questionId': e.key,
                  'question_id': e.key,
                  'selectedAnswer': e.value,
                  'selected_answer': e.value,
                },
              )
              .toList(),
          'fileUrls': filePaths,
          'file_urls': filePaths,
          'contentText': contentText,
          'notes': contentText,
          'content_text': contentText,
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AssignmentSubmissionModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToSubmitAssignment,
      );
    }
  }

  @override
  Future<void> deleteAttempt(String attemptId) async {
    try {
      await httpClient.delete('/api/assignment-attempts/$attemptId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getStudentAttempts(
    String studentId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/assignment-attempts/student/$studentId',
      );
      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data
          .map((e) => AssignmentSubmissionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAttemptsForAssignment(
    String assignmentId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/assignment-attempts/assignment/$assignmentId',
      );
      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data
          .map((e) => AssignmentSubmissionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getAssignmentStatistics(
    String assignmentId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/assignment-attempts/assignment/$assignmentId/statistics',
      );
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.unknown,
      );
    }
  }
}
