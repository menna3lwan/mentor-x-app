import 'package:mentorx_core/mentorx_core.dart';
import 'models/grade_models.dart';
export 'models/grade_models.dart';

final class DioParentGradeRepository
    extends HttpClientRepository<ParentGradeRepositoryExceptionCode>
    implements ParentGradeRepository {
  final HttpClient httpClient;

  DioParentGradeRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentGradeRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentGradeRepositoryException(code: code, message: message);
  }

  @override
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/overview',
      );

      final data = response.asMap();
      return ParentGradeSummaryModel(
        overallAverage: 0.0, // Not directly in ChildOverview
        totalAssessments: ModelParser.asInt(data['completedLessons']),
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      // Backend doesn't have a specific trend endpoint yet
      return const ParentGradeTrendModel(months: []);
    } catch (e) {
      return throwException(
        ParentGradeRepositoryExceptionCode.fetchError,
        message: e.toString(),
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
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/assessments',
        queryParameters: {
          if (type != null) 'type': type,
          if (courseId != null) 'courseId': courseId,
        },
      );

      final list = response.asList();
      return list.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentGradeRepositoryExceptionCode.fetchError,
      );
    }
  }
}
