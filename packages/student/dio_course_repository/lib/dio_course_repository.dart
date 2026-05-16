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
  Future<List<EnrollmentEntity>> getEnrolledCourses({
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

      return response
          .asList()
          .map(asMap)
          .map(EnrollmentModel.fromJson)
          .cast<EnrollmentEntity>()
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
          if (gradeId != null) 'gradeId': gradeId,
          if (categoryId != null) 'categoryId': categoryId,
          if (search != null) 'search': search,
          if (sort != null) 'sort': sort,
          if (order != null) 'order': order,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      return response
          .asList()
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

      return response.asList().map(asMap).map(CategoryModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCategories,
      );
    }
  }

  @override
  Future<List<CategoryEntity>> getCategoriesByLevel(String levelId) async {
    try {
      final response = await httpClient.get(
        '/api/categories/level/$levelId',
      );

      final list = response.asList();

      return list
          .map(asMap)
          .map(CategoryModel.fromJson)
          .cast<CategoryEntity>()
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCategories,
      );
    }
  }

  @override
  Future<List<LevelEntity>> getLevels() async {
    try {
      final response = await httpClient.get('/api/levels');
      return response
          .asList()
          .map(asMap)
          .map(LevelModel.fromJson)
          .cast<LevelEntity>()
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadCatalog,
      );
    }
  }

  @override
  Future<CourseEntity> getCourseDetail(String courseId) async {
    try {
      final response = await httpClient.get('/api/courses/$courseId');

      return CourseModel.fromJson(response.asMap());
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

      return response.asList().map(asMap).map(SessionModel.fromJson).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadSessions,
      );
    }
  }

  @override
  Future<List<WeekEntity>> getSessionWeeks(String sessionId) async {
    try {
      final response = await httpClient.get('/api/weeks/session/$sessionId');
      final weeks = response
          .asList()
          .map(asMap)
          .map(WeekModel.fromJson)
          .cast<WeekEntity>()
          .toList();

      if (weeks.isEmpty) return const [];

      // Fetch materials for each week in parallel to populate week.materials
      final weekWithItemsFutures = weeks.map((week) async {
        try {
          final res = await httpClient.get('/api/materials/lesson/${week.id}');
          final items = res
              .asList()
              .map(asMap)
              .map(SessionItemModel.fromJson)
              .cast<SessionItemEntity>()
              .toList();
          return week.copyWith(materials: items);
        } catch (_) {
          return week;
        }
      });

      return await Future.wait(weekWithItemsFutures);
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
      // Use getSessionWeeks which now populates materials, then flatten
      final weeks = await getSessionWeeks(sessionId);
      return weeks.expand((w) => w.materials).toList();
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
      final data = response.asMap();

      // Backend EnrollmentController.checkEnrollment: {enrolled: bool, enrollment: {...}}
      if (boolOrFalse(data['enrolled'])) {
        final enrollmentData = asMap(data['enrollment']);
        if (enrollmentData.isNotEmpty) {
          return EnrollmentModel.fromJson(enrollmentData);
        }
      }
      return null;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadProgress,
      );
    }
  }

  @override
  Future<EnrollmentEntity> enrollInCourse(String courseId) async {
    try {
      // NOTE: Enrollments are typically handled via PaymentService in the backend
      // But if there's a direct enrollment endpoint for free courses or manual:
      final response = await httpClient.post(
        '/api/student/enrollments',
        data: {'course_id': courseId},
      );

      final data = response.asMap();
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
      final data = response.asMap();

      // LessonMaterialResponse uses embedUrl for streaming, youtubeVideoId as fallback
      return stringOrEmpty(
        data['embedUrl'] ?? data['youtubeVideoId'] ?? data['fileUrl'],
      );
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
      final data = response.asMap();

      // LessonMaterialResponse uses fileUrl for downloadable content
      return stringOrEmpty(data['fileUrl'] ?? data['embedUrl']);
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
  Future<void> recordCourseAccess(String enrollmentId) async {
    try {
      await httpClient.post('/api/enrollments/$enrollmentId/access');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getLessonStatus(String weekId) async {
    try {
      final response = await httpClient.get('/api/weeks/$weekId/status');
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadProgress,
      );
    }
  }

  @override
  Future<void> completeLesson(
    String weekId, {
    double? quizScore,
    double? passingScore,
  }) async {
    try {
      await httpClient.post(
        '/api/weeks/$weekId/complete',
        queryParameters: {
          if (quizScore != null) 'quizScore': quizScore,
          if (passingScore != null) 'passingScore': passingScore,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToMarkComplete,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSessionProgress(
    String sessionId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/weeks/session/$sessionId/my-progress',
      );
      return response.asList().map(asMap).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToLoadProgress,
      );
    }
  }

  @override
  Future<void> updateCourse(String courseId, Map<String, dynamic> data) async {
    try {
      await httpClient.put('/api/courses/$courseId', data: data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> deleteCourse(String courseId) async {
    try {
      await httpClient.delete('/api/courses/$courseId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<CourseEntity> createCourse(Map<String, dynamic> data) async {
    try {
      final response = await httpClient.post('/api/courses', data: data);
      final responseData = asMap(response.data)['data'] ?? asMap(response.data);
      return CourseModel.fromJson(responseData);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> toggleCourseStatus(String courseId) async {
    try {
      await httpClient.patch('/api/courses/$courseId/toggle-status');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> completeEnrollment(String enrollmentId) async {
    try {
      await httpClient.post('/api/enrollments/$enrollmentId/complete');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToMarkComplete,
      );
    }
  }

  @override
  Future<void> grantEnrollmentAccess(String enrollmentId) async {
    // NOTE: In backend this seems to be recordAccess for student.
    // Admin grant is /api/enrollments/admin/grant
    try {
      await httpClient.post('/api/enrollments/$enrollmentId/access');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.failedToEnroll,
      );
    }
  }

  @override
  Future<void> expireOldEnrollments() async {
    try {
      await httpClient.post('/api/enrollments/admin/expire-old');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> extendEnrollment(String enrollmentId, int days) async {
    try {
      // Backend: PatchMapping("/admin/{enrollmentId}/extend")
      await httpClient.patch(
        '/api/enrollments/admin/$enrollmentId/extend',
        queryParameters: {
          'newExpiry': DateTime.now()
              .add(Duration(days: days))
              .toIso8601String(),
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getMyEnrollmentStats() async {
    try {
      final response = await httpClient.get('/api/enrollments/stats/my-stats');
      return response.asMap();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<EnrollmentEntity>> getStudentEnrollments(String studentId) async {
    try {
      final response = await httpClient.get(
        '/api/enrollments/admin/student/$studentId',
      );
      final list = asList(asMap(response.data)['data'] ?? response.data);
      return list
          .map(asMap)
          .map(EnrollmentModel.fromJson)
          .cast<EnrollmentEntity>()
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<EnrollmentEntity>> getCourseEnrollments(String courseId) async {
    try {
      final response = await httpClient.get(
        '/api/enrollments/admin/course/$courseId',
      );
      final list = asList(asMap(response.data)['data'] ?? response.data);
      return list
          .map(asMap)
          .map(EnrollmentModel.fromJson)
          .cast<EnrollmentEntity>()
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> deleteEnrollment(String enrollmentId) async {
    try {
      await httpClient.delete('/api/enrollments/admin/$enrollmentId');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> cancelAllStudentEnrollments(String studentId) async {
    try {
      await httpClient.delete(
        '/api/enrollments/admin/student/$studentId/cancel-all',
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: CourseRepositoryExceptionCode.unknown,
      );
    }
  }
}
