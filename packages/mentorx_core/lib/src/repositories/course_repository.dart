part of '../../mentorx_core.dart';

enum CourseRepositoryExceptionCode {
  unknown,
  failedToLoadCourses,
  failedToLoadCatalog,
  failedToLoadCategories,
  failedToLoadCourseDetail,
  failedToLoadSessions,
  failedToLoadProgress,
  failedToLoadGrades,
  failedToEnroll,
  failedToLoadStreamUrl,
  failedToLoadContentUrl,
  failedToUpdateProgress,
  failedToMarkComplete,
}

final class CourseRepositoryException
    extends MentorXException<CourseRepositoryExceptionCode> {
  CourseRepositoryException({required super.code, super.message});
}

abstract interface class CourseRepository {
  Future<void> initialize();

  /// Fetch enrolled courses with optional status filter and pagination.
  Future<List<CourseSummaryEntity>> getEnrolledCourses({
    String? status,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Browse course catalog with filtering, sorting, and pagination.
  Future<List<CourseSummaryEntity>> getCourseCatalog({
    String? gradeId,
    String? categoryId,
    String? search,
    String? sort,
    String? order,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch course categories for a given grade.
  Future<List<CategoryEntity>> getCategories({String? gradeId});

  /// Fetch full course detail by ID.
  Future<CourseEntity> getCourseDetail(String courseId);

  /// Fetch sessions with items for a course.
  Future<List<SessionEntity>> getCourseSessions(String courseId);

  /// Fetch items for a specific session.
  Future<List<SessionItemEntity>> getSessionItems(String sessionId);

  /// Fetch enrollment and progress for a course.
  Future<EnrollmentEntity?> getCourseProgress(String courseId);

  /// Enroll the current student in a course.
  Future<EnrollmentEntity> enrollInCourse(String courseId);

  /// Get a signed video streaming URL.
  Future<String> getStreamUrl(String itemId);

  /// Get a signed content URL (PDF, etc.).
  Future<String> getContentUrl(String itemId);

  /// Update watch/read progress for a session item.
  Future<void> updateProgress(
    String itemId, {
    int? watchTimeSeconds,
    int? lastPositionSeconds,
    double? progressPercent,
  });

  /// Mark a session item as complete.
  Future<void> markItemComplete(String itemId);
}
