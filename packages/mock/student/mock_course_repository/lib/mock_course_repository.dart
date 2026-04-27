import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockCourseRepository implements CourseRepository {
  final Duration delay;

  const MockCourseRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<CourseSummaryEntity>> getEnrolledCourses({
    String? status,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    final courses = MockCourseGenerator.enrolledCourses(
      status: status,
      languageCode: 'ar',
    );
    if (search != null && search.isNotEmpty) {
      final query = search.toLowerCase();
      return courses
          .where((c) => c.title.toLowerCase().contains(query))
          .toList();
    }
    return courses;
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
    await Future<void>.delayed(delay);
    var courses = MockCourseGenerator.catalogCourses();
    if (search != null && search.isNotEmpty) {
      final query = search.toLowerCase();
      courses = courses
          .where((c) => c.title.toLowerCase().contains(query))
          .toList();
    }
    if (sort == 'price' && order == 'asc') {
      courses = List.of(courses)
        ..sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else if (sort == 'price' && order == 'desc') {
      courses = List.of(courses)
        ..sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
    } else if (sort == 'enrolled') {
      courses = List.of(courses)
        ..sort((a, b) => b.enrolledCount.compareTo(a.enrolledCount));
    }
    return courses;
  }

  @override
  Future<List<CategoryEntity>> getCategories({String? gradeId}) async {
    await Future<void>.delayed(delay ~/ 2);
    return MockCourseGenerator.categories();
  }

  @override
  Future<CourseEntity> getCourseDetail(String courseId) async {
    await Future<void>.delayed(delay);
    return MockCourseGenerator.courseDetail(courseId);
  }

  @override
  Future<List<SessionEntity>> getCourseSessions(String courseId) async {
    await Future<void>.delayed(delay);
    return MockCourseGenerator.courseSessions(courseId);
  }

  @override
  Future<List<SessionItemEntity>> getSessionItems(String sessionId) async {
    await Future<void>.delayed(delay ~/ 2);
    return MockCourseGenerator.sessionItems(sessionId);
  }

  @override
  Future<EnrollmentEntity?> getCourseProgress(String courseId) async {
    await Future<void>.delayed(delay ~/ 2);
    // Return null for non-enrolled courses, progress for enrolled
    if (courseId.startsWith('ep') || courseId.startsWith('ec')) {
      return MockCourseGenerator.courseProgress(courseId);
    }
    return null;
  }

  @override
  Future<EnrollmentEntity> enrollInCourse(String courseId) async {
    await Future<void>.delayed(delay);
    return MockCourseGenerator.enrollResult(courseId);
  }

  @override
  Future<String> getStreamUrl(String itemId) async {
    await Future<void>.delayed(delay ~/ 2);
    return 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4';
  }

  @override
  Future<String> getContentUrl(String itemId) async {
    await Future<void>.delayed(delay ~/ 2);
    return 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  }

  @override
  Future<void> updateEnrollmentProgress(
    String enrollmentId, {
    required double progress,
    required int watchTimeSeconds,
    required int completedLessons,
    required int totalLessons,
  }) async {
    await Future<void>.delayed(delay ~/ 2);
  }
}
