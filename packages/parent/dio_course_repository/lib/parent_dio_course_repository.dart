import 'package:mentorx_core/mentorx_core.dart';
import 'models/course_models.dart';
export 'models/course_models.dart';

final class DioParentCourseRepository
    extends HttpClientRepository<ParentCourseRepositoryExceptionCode>
    implements ParentCourseRepository {
  final HttpClient httpClient;

  DioParentCourseRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentCourseRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentCourseRepositoryException(code: code, message: message);
  }

  @override
  Future<List<CourseEntity>> getCourses(
    String childId, {
    String? status,
  }) async {
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.get(
          '/api/parent/children/$childId/courses',
          queryParameters: {
            if (status != null) 'status': status,
          },
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await httpClient.get(
          '/api/parent/dashboard/child/$childId/enrollments',
          queryParameters: {
            if (status != null) 'status': status,
          },
        );
      }

      final data = asList(response.data);
      return data.map((e) => CourseModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCourseRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<CourseSummaryEntity> getCourseProgress(
    String childId,
    String courseId,
  ) async {
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.get(
          '/api/parent/children/$childId/courses/$courseId/progress',
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await httpClient.get(
          '/api/parent/dashboard/child/$childId/progress/$courseId',
        );
      }

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return CourseSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCourseRepositoryExceptionCode.fetchError,
        codeFromStatusCode: (status) => status == 404
            ? ParentCourseRepositoryExceptionCode.courseNotFound
            : ParentCourseRepositoryExceptionCode.fetchError,
      );
    }
  }
}
