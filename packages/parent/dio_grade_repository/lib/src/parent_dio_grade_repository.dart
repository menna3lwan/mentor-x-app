import 'package:mentorx_core/mentorx_core.dart';
import 'models/grade_models.dart';

final class DioParentGradeRepository
    extends HttpClientRepository<ParentGradeRepositoryExceptionCode>
    implements ParentGradeRepository {
  final HttpClient httpClient;

  DioParentGradeRepository({required this.httpClient});

  @override
  Never throwException(
    ParentGradeRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentGradeRepositoryException(code: code, message: message);
  }

  @override
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId) async {
    const defaultException = ParentGradeRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/grades/summary',
      );

      return ParentGradeSummaryModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<ParentGradeTrendEntity> getGradeTrend(
    String childId, {
    int months = 6,
  }) async {
    const defaultException = ParentGradeRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/grades/trend',
        queryParameters: {'months': months},
      );

      return ParentGradeTrendModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<List<QuizAttemptEntity>> getAssessments(
    String childId, {
    String? type,
    String? courseId,
  }) async {
    const defaultException = ParentGradeRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/assessments',
        queryParameters: {
          if (type != null) 'type': type,
          if (courseId != null) 'course_id': courseId,
        },
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => QuizAttemptModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }
}
