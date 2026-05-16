import 'package:mentorx_core/mentorx_core.dart';
import 'models/children_models.dart';
export 'models/children_models.dart';

final class DioParentChildrenRepository
    extends HttpClientRepository<AuthenticationExceptionCode>
    implements ParentChildrenRepository {
  DioParentChildrenRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  }) : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    AuthenticationExceptionCode code, {
    String? message,
  }) => throw AuthenticationException(code: code, message: message);

  final HttpClient _httpClient;

  @override
  Future<List<ParentChildEntity>> getChildren() async {
    try {
      final response = await _httpClient.get('/api/parent/children');
      final list = response.asList();
      return list
          .map((json) => ParentChildModel.fromJson(asMap(json)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.unknown,
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
        data: {
          'lookupType': query.contains('01') ? 'PHONE' : 'STUDENT_CODE',
          'value': query,
        },
      );

      final data = response.asMap();
      return ParentStudentLookupModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      final response = await _httpClient.post(
        '/api/parent/link-child',
        data: {
          'studentId': studentId,
          'relationship': relationship,
        },
      );

      final data = response.asMap();
      return ParentChildModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.registrationFailed,
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
        defaultCode: AuthenticationExceptionCode.unknown,
      );
    }
  }
}
