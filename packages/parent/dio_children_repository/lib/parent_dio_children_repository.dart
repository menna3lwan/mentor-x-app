import 'package:mentorx_core/mentorx_core.dart';
import 'models/children_models.dart';
export 'models/children_models.dart';

final class DioParentChildrenRepository
    extends HttpClientRepository<ParentChildrenRepositoryExceptionCode>
    implements ParentChildrenRepository {
  final HttpClient _httpClient;

  DioParentChildrenRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentChildrenRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentChildrenRepositoryException(code: code, message: message);

  @override
  Future<List<ParentChildEntity>> getChildren() async {
    // Backend contract (Postman): GET /api/parent/children — envelope shape
    // is {success, data:[...]} or {success, data:{content:[...]}}.
    try {
      final response = await _httpClient.get('/api/parent/children');

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final list = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return list
          .map((json) => ParentChildModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentChildrenRepositoryExceptionCode.fetchError,
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // API-CONTRACT (KNOWN MISMATCH):
  // /api/parent/find-student, /api/parent/link-child, and
  // DELETE /api/parent/children/{id} are NOT declared in the EduCore Postman
  // collection. They are kept as-is so the existing UI flow keeps compiling
  // and exercising the Mock repository in development. Any 404/405 from a
  // real backend is surfaced as a typed exception so the UI can display a
  // localized "service unavailable" toast instead of crashing.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ParentStudentLookupEntity> findStudentByChildQuery({
    required String query,
  }) async {
    try {
      final response = await _httpClient.post(
        '/api/parent/find-student',
        data: {'value': query},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentStudentLookupModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentChildrenRepositoryExceptionCode.studentNotFound,
      );
    }
  }

  @override
  Future<ParentChildEntity> linkChild({
    required String studentId,
    required String relationship,
  }) async {
    try {
      final response = await _httpClient.post(
        '/api/parent/link-child',
        data: {
          'studentId': studentId,
          'student_id': studentId,
          'relationship': relationship,
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentChildModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentChildrenRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<void> unlinkChild(String childId) async {
    try {
      await _httpClient.delete('/api/parent/children/$childId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentChildrenRepositoryExceptionCode.unknown,
      );
    }
  }
}
