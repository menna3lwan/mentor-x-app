import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'package:dio_assignment_repository/dio_assignment_repository.dart';

final class DioGradeRepository
    extends HttpClientRepository<GradeRepositoryExceptionCode>
    implements GradeRepository {
  @override
  Never throwException(GradeRepositoryExceptionCode code, {String? message}) =>
      throw GradeRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioGradeRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (courseId != null) 'course_id': courseId,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/quiz-attempts/student/me',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);

      return list.map((e) => QuizAttemptModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: GradeRepositoryExceptionCode.failedToLoadQuizResults,
      );
    }
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (courseId != null) 'course_id': courseId,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/assignment-attempts/student/me',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);

      return list.map((e) => AssignmentSubmissionModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: GradeRepositoryExceptionCode.failedToLoadAssignmentResults,
      );
    }
  }

}
