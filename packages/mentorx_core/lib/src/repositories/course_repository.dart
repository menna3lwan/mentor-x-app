part of 'package:mentorx_core/mentorx_core.dart';

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
  Future<List<EnrollmentEntity>> getEnrolledCourses({
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

  /// Fetch course categories for a given level.
  Future<List<CategoryEntity>> getCategoriesByLevel(String levelId);

  /// Fetch all course levels.
  Future<List<LevelEntity>> getLevels();

  /// Fetch full course detail by ID.
  Future<CourseEntity> getCourseDetail(String courseId);

  /// Fetch sessions for a course.
  Future<List<SessionEntity>> getCourseSessions(String courseId);

  /// Fetch weeks for a specific session.
  Future<List<WeekEntity>> getSessionWeeks(String sessionId);

  /// Fetch items for a specific session.
  Future<List<SessionItemEntity>> getSessionItems(String sessionId);

  /// Fetch enrollment and progress for a course.
  Future<EnrollmentEntity?> getCourseProgress(String courseId);

  /// Enroll the current student in a course.
  Future<EnrollmentEntity> enrollInCourse(String courseId, {String? couponCode});

  /// Get a signed video streaming URL.
  Future<String> getStreamUrl(String itemId);

  /// Get a signed content URL (PDF, etc.).
  Future<String> getContentUrl(String itemId);

  /// Update course-wide enrollment progress.
  Future<void> updateEnrollmentProgress(
    String enrollmentId, {
    required double progress,
    required int watchTimeSeconds,
    required int completedLessons,
    required int totalLessons,
  });

  /// Record a visit to a course.
  Future<void> recordCourseAccess(String enrollmentId);

  // Lesson Gate & Progress
  /// Fetch the status of a specific lesson for the current student.
  Future<Map<String, dynamic>> getLessonStatus(String weekId);

  /// Mark a lesson as completed, optionally providing a quiz score.
  Future<void> completeLesson(
    String weekId, {
    double? quizScore,
    double? passingScore,
  });

  /// Fetch student progress for all lessons in a session.
  Future<List<Map<String, dynamic>>> getSessionProgress(String sessionId);

  // Pro Features
  Future<void> updateCourse(String courseId, Map<String, dynamic> data);
  Future<void> deleteCourse(String courseId);
  Future<CourseEntity> createCourse(Map<String, dynamic> data);
  Future<void> toggleCourseStatus(String courseId);
  Future<void> completeEnrollment(String enrollmentId);
  Future<void> grantEnrollmentAccess(String enrollmentId);
  Future<void> expireOldEnrollments();
  Future<void> extendEnrollment(String enrollmentId, int days);
  Future<Map<String, dynamic>> getMyEnrollmentStats();
  Future<List<EnrollmentEntity>> getStudentEnrollments(String studentId);
  Future<List<EnrollmentEntity>> getCourseEnrollments(String courseId);
  Future<void> deleteEnrollment(String enrollmentId);
  Future<void> cancelAllStudentEnrollments(String studentId);
}
