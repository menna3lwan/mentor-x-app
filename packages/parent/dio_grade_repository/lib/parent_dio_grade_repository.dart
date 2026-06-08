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

  // ─────────────────────────────────────────────────────────────────────────
  // API-CONTRACT (KNOWN MISMATCH):
  // /api/parent/children/{id}/grades/summary, /grades/trend, /assessments are
  // NOT declared in the EduCore Postman collection. The closest backend
  // endpoints are under /api/analytics/parent/child/{id}/* (grade-comparison,
  // course-progress) but the shapes do not match these entities yet.
  // We keep the calls so the UI keeps compiling and exercising mock data,
  // and surface 404/405 as a graceful empty/default so the UI degrades
  // instead of throwing.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId) async {
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/grades/summary',
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentGradeSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentGradeSummaryModel.fromJson(const <String, dynamic>{});
      }
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
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentGradeTrendModel.fromJson(const <String, dynamic>{});
      }
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
          if (courseId != null) 'courseId': courseId,
          if (courseId != null) 'course_id': courseId,
        },
      );

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <QuizAttemptEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentGradeRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classify,
      );
    }
  }

  ParentGradeRepositoryExceptionCode _classify(int statusCode) {
    return switch (statusCode) {
      401 || 403 => ParentGradeRepositoryExceptionCode.unauthorized,
      _ => ParentGradeRepositoryExceptionCode.fetchError,
    };
  }
}
