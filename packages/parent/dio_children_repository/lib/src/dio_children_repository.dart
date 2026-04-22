import 'package:mentorx_core/mentorx_core.dart';
import '../models/children_models.dart';


final class DioParentChildrenRepository extends HttpClientRepository<AuthenticationExceptionCode>
    implements ParentChildrenRepository {

  DioParentChildrenRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient;

  @override
  Never throwException(
    AuthenticationExceptionCode code, {
    String? message,
  }) => throw AuthenticationException(code: code, message: message);

  final HttpClient _httpClient;

  @override
  Future<List<ParentChildEntity>> getChildren() async {
    try {
      final response = await _httpClient.get('/api/v1/parent/children');
      final data = asList(response.data);
      return data
          .map((json) => ParentChildModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.registrationFailed,
      );
    }
  }

  @override
  Future<ParentStudentLookupEntity> findStudentByChildQuery({
    required String query,
  }) async {
    try {
      final response = await _httpClient.post('/api/v1/parent/find-student', data: {
        'value': query,
      });

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentStudentLookupModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.studentNotFound,
      );
    }
  }

  @override
  Future<ParentChildEntity> linkChild({
    required String studentId,
    required String relationship,
  }) async {
    try {
      final response = await _httpClient.post('/api/v1/parent/link-child', data: {
        'student_id': studentId,
        'relationship': relationship,
      });

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentChildModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.registrationFailed,
      );
    }
  }

  @override
  Future<void> unlinkChild(String childId) async {
    try {
      await _httpClient.delete('/api/v1/parent/children/$childId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.unknown,
      );
    }
  }

}
