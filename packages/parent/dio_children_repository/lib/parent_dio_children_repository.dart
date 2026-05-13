import 'package:mentorx_core/mentorx_core.dart';
import 'models/children_models.dart';
export 'models/children_models.dart';


final class DioParentChildrenRepository extends HttpClientRepository<AuthenticationExceptionCode>
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
      HttpClientResponse response;
      try {
        response = await _httpClient.get('/api/parent/children');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await _httpClient.get('/api/parent/children');
      }
      
      final data = asMap(response.data)['data'] ?? asList(response.data);
      final list = asList(data);
      return list
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
      HttpClientResponse response;
      try {
        response = await _httpClient.post('/api/parent/find-student', data: {
          'value': query,
        });
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await _httpClient.post('/api/parent/find-student', data: {
          'value': query,
        });
      }

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
      HttpClientResponse response;
      try {
        response = await _httpClient.post('/api/parent/link-child', data: {
          'student_id': studentId,
          'relationship': relationship,
        });
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await _httpClient.post('/api/parent/link-child', data: {
          'student_id': studentId,
          'relationship': relationship,
        });
      }

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
      try {
        await _httpClient.delete('/api/parent/children/$childId');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        await _httpClient.delete('/api/parent/children/$childId');
      }
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: AuthenticationExceptionCode.unknown,
      );
    }
  }

}
