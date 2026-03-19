import 'package:student_core/student_core.dart';
import 'package:dio/dio.dart'; // For MultipartFile
import '../models/assignment_models.dart';

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
    final response = await httpClient.get('/api/assignments/$assignmentId');

    if (response.statusCode != 200) {
      throw AssignmentRepositoryException(
        code: AssignmentRepositoryExceptionCode.failedToLoadAssignment,
        message: response.exception?.message,
      );
    }

    return AssignmentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<AssignmentSubmissionEntity?> getSubmission(String assignmentId) async {
    final response = await httpClient.get('/api/assignments/$assignmentId/submission');

    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw AssignmentRepositoryException(
        code: AssignmentRepositoryExceptionCode.failedToLoadSubmission,
        message: response.exception?.message,
      );
    }

    return AssignmentSubmissionModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<List<String>> uploadFiles(List<String> localFilePaths) async {
    try {
      final List<MultipartFile> files = [];
      for (final path in localFilePaths) {
        files.add(await MultipartFile.fromFile(path));
      }

      final formData = FormData.fromMap({
        'files': files,
      });

      // Assuming we have a dedicated upload endpoint or can pass FormData to HttpClient
      // Our DioHttpClient might need a specific method for FormData if it doesn't support it in 'post'
      // For now, let's assume it works or we need to add it.
      
      final response = await httpClient.post(
        '/api/uploads/assignment-files',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AssignmentRepositoryException(
          code: AssignmentRepositoryExceptionCode.failedToUploadFiles,
        );
      }

      final data = response.data['data'] as List;
      return data.map((e) => e['url'].toString()).toList();
    } catch (e) {
      throw AssignmentRepositoryException(
        code: AssignmentRepositoryExceptionCode.failedToUploadFiles,
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
    final response = await httpClient.post(
      '/api/assignments/$assignmentId/submit',
      data: {
        'file_urls': fileUrls,
        if (notes != null) 'student_notes': notes,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw AssignmentRepositoryException(
        code: AssignmentRepositoryExceptionCode.failedToSubmitAssignment,
        message: response.exception?.message,
      );
    }

    return AssignmentSubmissionModel.fromJson(response.data['data'] ?? response.data);
  }
}
