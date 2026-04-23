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
      final response = await httpClient.get('/api/assignments/$assignmentId/submission');
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
  Future<List<String>> uploadFiles(List<String> localFilePaths) async {
    try {
      final response = await httpClient.postMultipart(
        '/api/uploads/assignment-files',
        files: {'files': localFilePaths},
      );

      final data = asList(response.data);
      return data.map((e) => asMap(e)['url'].toString()).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AssignmentRepositoryExceptionCode.failedToUploadFiles,
      );
    } catch (e) {
      throwException(
        AssignmentRepositoryExceptionCode.failedToUploadFiles,
        message: e.toString(),
      );
    }
  }

  @override
  Future<AssignmentSubmissionEntity> submitAssignment(
    String assignmentId, {
    required List<String> fileUrls,
    String? notes,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/assignments/$assignmentId/submit',
        data: {
          'file_urls': fileUrls,
          if (notes != null) 'student_notes': notes,
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

}
