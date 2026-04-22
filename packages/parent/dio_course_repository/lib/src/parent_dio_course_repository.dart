import 'package:mentorx_core/mentorx_core.dart';
import 'models/course_models.dart';

final class DioParentCourseRepository
    extends HttpClientRepository<ParentCourseRepositoryExceptionCode>
    implements ParentCourseRepository {
  final HttpClient httpClient;

  DioParentCourseRepository({required this.httpClient});

  @override
  Never throwException(
    ParentCourseRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentCourseRepositoryException(code: code, message: message);
  }

  @override
  Future<List<CourseEntity>> getCourses(String childId, {String? status}) async {
    const defaultException = ParentCourseRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/courses',
        queryParameters: status != null ? {'status': status} : null,
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => CourseModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<CourseSummaryEntity> getCourseProgress(
    String childId,
    String courseId,
  ) async {
    const defaultException = ParentCourseRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/courses/$courseId/progress',
      );

      return CourseSummaryModel.fromJson(response.data['data'] ?? response.data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) {
        throwException(ParentCourseRepositoryExceptionCode.courseNotFound);
      }
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }
}
