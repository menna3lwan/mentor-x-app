import 'package:mentorx_core/mentorx_core.dart';
import 'models/grade_models.dart';
export 'models/grade_models.dart';

final class DioParentGradeRepository
    extends HttpClientRepository<ParentGradeRepositoryExceptionCode>
    implements ParentGradeRepository {
  final HttpClient _httpClient;

  DioParentGradeRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentGradeRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentGradeRepositoryException(code: code, message: message);

  @override
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/grades/summary',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentGradeSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentGradeRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<ParentGradeTrendEntity> getGradeTrend(
    String childId, {
    int months = 6,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/grades/trend',
        queryParameters: {'months': months},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentGradeTrendModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentGradeRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<QuizAttemptEntity>> getAssessments(
    String childId, {
    String? type,
    String? courseId,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/assessments',
        queryParameters: {
          if (type != null) 'type': type,
          if (courseId != null) 'course_id': courseId,
        },
      );

      final data = asList(response.data);
      return data.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentGradeRepositoryExceptionCode.fetchError,
      );
    }
  }
}
