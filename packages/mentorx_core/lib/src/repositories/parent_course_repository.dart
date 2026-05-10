part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentCourseRepositoryExceptionCode {
  unknown,
  fetchError,
  courseNotFound,
}

final class ParentCourseRepositoryException
    extends MentorXException<ParentCourseRepositoryExceptionCode> {
  const ParentCourseRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentCourseRepository {
  Future<void> initialize();
  Future<List<CourseEntity>> getCourses(String childId, {String? status});
  Future<CourseSummaryEntity> getCourseProgress(String childId, String courseId);
}
