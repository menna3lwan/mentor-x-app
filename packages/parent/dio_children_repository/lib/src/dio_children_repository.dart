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
      if (response.isOk) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data
            .map((json) => ParentChildModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        AuthenticationExceptionCode.registrationFailed,
        e,
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

      if (response.isOk) {
        final data = response.data['data'] as Map<String, dynamic>;
        return ParentStudentLookupModel.fromJson(data);
      }
      
      throw const AuthenticationException(code: AuthenticationExceptionCode.studentNotFound);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        AuthenticationExceptionCode.studentNotFound,
        e,
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

      if (response.isOk) {
        return ParentChildModel.fromJson(response.data['data'] as Map<String, dynamic>);
      }
      
      throw const AuthenticationException(code: AuthenticationExceptionCode.registrationFailed);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        AuthenticationExceptionCode.registrationFailed,
        e,
      );
    }
  }

  @override
  Future<void> unlinkChild(String childId) async {
    try {
      await _httpClient.delete('/api/v1/parent/children/$childId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        AuthenticationExceptionCode.unknown,
        e,
      );
    }
  }
}
