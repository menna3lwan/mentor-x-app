import 'package:mentorx_core/mentorx_core.dart';
import '../models/course_models.dart';
import '../models/session_models.dart';

final class DioCourseRepository
    extends HttpClientRepository<CourseRepositoryExceptionCode>
    implements CourseRepository {
  @override
  Never throwException(CourseRepositoryExceptionCode code, {String? message}) =>
      throw CourseRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioCourseRepository({required this.httpClient});

  @override
  Future<List<CourseSummaryEntity>> getEnrolledCourses({
    String? status,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/student/courses',
      queryParameters: {
        if (status != null) 'status': status,
        if (search != null) 'search': search,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadCourses,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map((e) => CourseSummaryModel.fromJson(e)).toList();
  }

  @override
  Future<List<CourseSummaryEntity>> getCourseCatalog({
    String? gradeId,
    String? categoryId,
    String? search,
    String? sort,
    String? order,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/courses',
      queryParameters: {
        if (gradeId != null) 'grade_id': gradeId,
        if (categoryId != null) 'category_id': categoryId,
        if (search != null) 'search': search,
        if (sort != null) 'sort': sort,
        if (order != null) 'order': order,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadCatalog,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map((e) => CourseSummaryModel.fromJson(e)).toList();
  }

  @override
  Future<List<CategoryEntity>> getCategories({String? gradeId}) async {
    final response = await httpClient.get(
      '/api/categories',
      queryParameters: {if (gradeId != null) 'grade_id': gradeId},
    );

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadCategories,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<CourseEntity> getCourseDetail(String courseId) async {
    final response = await httpClient.get('/api/courses/$courseId');

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadCourseDetail,
        message: response.exception?.message,
      );
    }

    return CourseModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<List<SessionEntity>> getCourseSessions(String courseId) async {
    final response = await httpClient.get('/api/courses/$courseId/sessions');

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadSessions,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map((e) => SessionModel.fromJson(e)).toList();
  }

  @override
  Future<List<SessionItemEntity>> getSessionItems(String sessionId) async {
    final response = await httpClient.get('/api/sessions/$sessionId/items');

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadSessions,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map((e) => SessionItemModel.fromJson(e)).toList();
  }

  @override
  Future<EnrollmentEntity?> getCourseProgress(String courseId) async {
    final response = await httpClient.get('/api/student/enrollments/$courseId');

    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadProgress,
        message: response.exception?.message,
      );
    }

    return EnrollmentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<EnrollmentEntity> enrollInCourse(String courseId) async {
    final response = await httpClient.post(
      '/api/student/enrollments',
      data: {'course_id': courseId},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToEnroll,
        message: response.exception?.message,
      );
    }

    return EnrollmentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<String> getStreamUrl(String itemId) async {
    final response = await httpClient.get('/api/sessions/items/$itemId/stream');

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadStreamUrl,
        message: response.exception?.message,
      );
    }

    return (response.data['url'] ?? response.data['data']?['url']).toString();
  }

  @override
  Future<String> getContentUrl(String itemId) async {
    final response = await httpClient.get('/api/sessions/items/$itemId/content');

    if (response.statusCode != 200) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToLoadContentUrl,
        message: response.exception?.message,
      );
    }

    return (response.data['url'] ?? response.data['data']?['url']).toString();
  }

  @override
  Future<void> updateProgress(
    String itemId, {
    int? watchTimeSeconds,
    int? lastPositionSeconds,
    double? progressPercent,
  }) async {
    final response = await httpClient.post(
      '/api/sessions/items/$itemId/progress',
      data: {
        if (watchTimeSeconds != null) 'watch_time_seconds': watchTimeSeconds,
        if (lastPositionSeconds != null) 'last_position_seconds': lastPositionSeconds,
        if (progressPercent != null) 'progress_percent': progressPercent,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToUpdateProgress,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<void> markItemComplete(String itemId) async {
    final response = await httpClient.post('/api/sessions/items/$itemId/complete');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw CourseRepositoryException(
        code: CourseRepositoryExceptionCode.failedToMarkComplete,
        message: response.exception?.message,
      );
    }
  }

  List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map<String, dynamic>) {
      final data = value['data'] ?? value['items'];
      if (data is List<dynamic>) return data;
    }
    return <dynamic>[];
  }
}
