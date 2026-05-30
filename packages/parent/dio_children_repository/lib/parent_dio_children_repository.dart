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
    try {
      final response = await _httpClient.get('/api/parent/children');

      final data = asMap(response.data)['data'] ?? asList(response.data);
      final list = asList(data);
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
