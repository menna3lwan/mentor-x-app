import 'package:mentorx_core/mentorx_core.dart';
import 'models/course_models.dart';
import 'models/session_models.dart';
export 'models/course_models.dart';
export 'models/session_models.dart';

final class DioCourseRepository
    extends HttpClientRepository<CourseRepositoryExceptionCode>
    implements CourseRepository {
  @override
  Never throwException(CourseRepositoryExceptionCode code, {String? message}) =>
      throw CourseRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioCourseRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<CourseSummaryEntity>> getEnrolledCourses({
    String? status,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/enrollments/my-enrollments',
        queryParameters: {
          if (status != null) 'status': status,
          if (search != null) 'search': search,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final list = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);

      return list
          .map(asMap)
          .map(CourseSummaryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCourses,
      );
    }
  }

  @override
  Future<List<CourseSummaryEntity>> getCourseCatalog({
    String? gradeId,
    String? categoryId,
    String? search,
    String? sort,
    String? order,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/courses',
        queryParameters: {
          if (gradeId != null) 'grade_id': gradeId,
          if (categoryId != null) 'category_id': categoryId,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort,
          if (order != null) 'order': order,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final list = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);

      return list
          .map(asMap)
          .map(CourseSummaryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCatalog,
      );
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories({String? gradeId}) async {
    try {
      final response = await httpClient.get(
        '/api/categories',
        queryParameters: {if (gradeId != null) 'grade_id': gradeId},
      );

      final list = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);

      return list
          .map(asMap)
          .map(CategoryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCategories,
      );
    }
  }

  @override
  Future<CourseEntity> getCourseDetail(String courseId) async {
    try {
      final response = await httpClient.get('/api/courses/$courseId');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return CourseModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCourseDetail,
      );
    }
  }

  @override
  Future<List<SessionEntity>> getCourseSessions(String courseId) async {
    try {
      final response = await httpClient.get('/api/sessions/course/$courseId');

      final list = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);

      return list
          .map(asMap)
          .map(SessionModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadSessions,
      );
    }
  }

  @override
  Future<List<SessionItemEntity>> getSessionItems(String sessionId) async {
    try {
      final response = await httpClient.get('/api/weeks/session/$sessionId');

      final list = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);

      return list
          .map(asMap)
          .map(SessionItemModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadSessions,
      );
    }
  }

  @override
  Future<EnrollmentEntity?> getCourseProgress(String courseId) async {
    try {
      final response = await httpClient.get('/api/enrollments/check/$courseId');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return EnrollmentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadProgress,
      );
    }
  }

  @override
  Future<EnrollmentEntity> enrollInCourse(String courseId) async {
    try {
      final response = await httpClient.post(
        '/api/student/enrollments',
        data: {'course_id': courseId},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return EnrollmentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToEnroll,
      );
    }
  }

  @override
  Future<String> getStreamUrl(String itemId) async {
    try {
      final response = await httpClient.get('/api/materials/$itemId');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return data['stream_url']?.toString() ?? data['url']?.toString() ?? '';
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadStreamUrl,
      );
    }
  }

  @override
  Future<String> getContentUrl(String itemId) async {
    try {
      final response = await httpClient.get('/api/materials/$itemId');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return data['content_url']?.toString() ?? data['url']?.toString() ?? '';
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadContentUrl,
      );
    }
  }

  @override
  Future<void> updateEnrollmentProgress(
    String enrollmentId, {
    required double progress,
    required int watchTimeSeconds,
    required int completedLessons,
    required int totalLessons,
  }) async {
    try {
      await httpClient.patch(
        '/api/enrollments/$enrollmentId/progress',
        data: {
          'progress': progress,
          'watchTimeSeconds': watchTimeSeconds,
          'completedLessons': completedLessons,
          'totalLessons': totalLessons,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToUpdateProgress,
      );
    }
  }

  @override
  Future<void> updateCourse(String courseId, Map<String, dynamic> data) async {
    try {
      await httpClient.put('/api/courses/$courseId', data: data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      await httpClient.delete('/api/courses/$courseId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<CourseEntity> createCourse(Map<String, dynamic> data) async {
    try {
      final response = await httpClient.post('/api/courses', data: data);
      final responseData = asMap(response.data)['data'] ?? asMap(response.data);
      return CourseModel.fromJson(responseData);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> toggleCourseStatus(String courseId) async {
    try {
      await httpClient.patch('/api/courses/$courseId/toggle-status');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> completeEnrollment(String enrollmentId) async {
    try {
      await httpClient.post('/api/enrollments/$enrollmentId/complete');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.failedToMarkComplete);
    }
  }

  @override
  Future<void> grantEnrollmentAccess(String enrollmentId) async {
    try {
      await httpClient.post('/api/enrollments/$enrollmentId/access');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.failedToEnroll);
    }
  }

  @override
  Future<void> expireOldEnrollments() async {
    try {
      await httpClient.post('/api/enrollments/admin/expire-old');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> extendEnrollment(String enrollmentId, int days) async {
    try {
      await httpClient.patch('/api/enrollments/admin/$enrollmentId/extend', data: {'days': days});
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<Map<String, dynamic>> getMyEnrollmentStats() async {
    try {
      final response = await httpClient.get('/api/enrollments/stats/my-stats');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<List<EnrollmentEntity>> getStudentEnrollments(String studentId) async {
    try {
      final response = await httpClient.get('/api/enrollments/admin/student/$studentId');
      final list = asList(asMap(response.data)['data'] ?? response.data);
      return list.map(asMap).map(EnrollmentModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<List<EnrollmentEntity>> getCourseEnrollments(String courseId) async {
    try {
      final response = await httpClient.get('/api/enrollments/admin/course/$courseId');
      final list = asList(asMap(response.data)['data'] ?? response.data);
      return list.map(asMap).map(EnrollmentModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> deleteEnrollment(String enrollmentId) async {
    try {
      await httpClient.delete('/api/enrollments/admin/$enrollmentId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }

  @override
  Future<void> cancelAllStudentEnrollments(String studentId) async {
    try {
      await httpClient.delete('/api/enrollments/admin/student/$studentId/cancel-all');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(e, defaultCode: CourseRepositoryExceptionCode.unknown);
    }
  }
}
