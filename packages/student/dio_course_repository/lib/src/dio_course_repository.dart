import 'package:mentorx_core/mentorx_core.dart';
import 'models/course_models.dart';
import 'models/session_models.dart';

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
        '/api/student/courses',
        queryParameters: {
          if (status != null) 'status': status,
          if (search != null) 'search': search,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      return asList(response.data)
          .map(asMap)
          .map(CourseSummaryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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

      return asList(response.data)
          .map(asMap)
          .map(CourseSummaryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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

      return asList(response.data)
          .map(asMap)
          .map(CategoryModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCourseDetail,
      );
    }
  }

  @override
  Future<List<SessionEntity>> getCourseSessions(String courseId) async {
    try {
      final response = await httpClient.get('/api/courses/$courseId/sessions');

      return asList(response.data)
          .map(asMap)
          .map(SessionModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadSessions,
      );
    }
  }

  @override
  Future<List<SessionItemEntity>> getSessionItems(String sessionId) async {
    try {
      final response = await httpClient.get('/api/sessions/$sessionId/items');

      return asList(response.data)
          .map(asMap)
          .map(SessionItemModel.fromJson)
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadSessions,
      );
    }
  }

  @override
  Future<EnrollmentEntity?> getCourseProgress(String courseId) async {
    try {
      final response = await httpClient.get('/api/student/enrollments/$courseId');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return EnrollmentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) return null;
      handleHttpClientErrorResponse(
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
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToEnroll,
      );
    }
  }

  @override
  Future<String> getStreamUrl(String itemId) async {
    try {
      final response = await httpClient.get('/api/sessions/items/$itemId/stream');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return data['url']?.toString() ?? '';
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadStreamUrl,
      );
    }
  }

  @override
  Future<String> getContentUrl(String itemId) async {
    try {
      final response = await httpClient.get('/api/sessions/items/$itemId/content');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return data['url']?.toString() ?? '';
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadContentUrl,
      );
    }
  }

  @override
  Future<void> updateProgress(
    String itemId, {
    int? watchTimeSeconds,
    int? lastPositionSeconds,
    double? progressPercent,
  }) async {
    try {
      await httpClient.post(
        '/api/sessions/items/$itemId/progress',
        data: {
          if (watchTimeSeconds != null) 'watch_time_seconds': watchTimeSeconds,
          if (lastPositionSeconds != null) 'last_position_seconds': lastPositionSeconds,
          if (progressPercent != null) 'progress_percent': progressPercent,
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
  Future<void> markItemComplete(String itemId) async {
    try {
      await httpClient.post('/api/sessions/items/$itemId/complete');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToMarkComplete,
      );
    }
  }

}
