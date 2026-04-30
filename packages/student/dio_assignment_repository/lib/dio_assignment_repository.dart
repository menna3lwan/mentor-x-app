import 'package:mentorx_core/mentorx_core.dart';
import 'models/assignment_models.dart';
export 'models/assignment_models.dart';

final class DioAssignmentRepository
    extends HttpClientRepository<AssignmentRepositoryExceptionCode>
    implements AssignmentRepository {
  @override
  Never throwException(AssignmentRepositoryExceptionCode code,
          {String? message}) =>
      throw AssignmentRepositoryException(code: code, message: message);

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
      handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToLoadAssignment,
      );
    }
  }

  @override
  Future<AssignmentSubmissionEntity?> getSubmission(String assignmentId) async {
    try {
      final response = await httpClient.get('/api/assignment-attempts/student/me/assignment/$assignmentId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AssignmentSubmissionModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      handleHttpClientErrorResponse(
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
          'answers': answers.entries
              .map((e) => {
                    'questionId': e.key,
                    'selectedAnswer': e.value,
                  })
              .toList(),
          'fileUrls': filePaths,
          'contentText': contentText,
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return AssignmentSubmissionModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
      handleHttpClientErrorResponse(e, defaultCode: AssignmentRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getStudentAttempts(String studentId) async {
    try {
      final response = await httpClient.get('/api/assignment-attempts/student/$studentId');
      final data = asList(asMap(response.data)['data'] ?? response.data);
      return data.map((e) => AssignmentSubmissionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: AssignmentRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAttemptsForAssignment(String assignmentId) async {
    try {
      final response = await httpClient.get('/api/assignment-attempts/assignment/$assignmentId');
      final data = asList(asMap(response.data)['data'] ?? response.data);
      return data.map((e) => AssignmentSubmissionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: AssignmentRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<Map<String, dynamic>> getAssignmentStatistics(String assignmentId) async {
    try {
      final response = await httpClient.get('/api/assignment-attempts/assignment/$assignmentId/statistics');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: AssignmentRepositoryExceptionCode.unknown);
    }
  }
}
