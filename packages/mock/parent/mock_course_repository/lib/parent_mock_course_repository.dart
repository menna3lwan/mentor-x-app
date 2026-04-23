import 'package:mentorx_core/mentorx_core.dart';

final class MockParentCourseRepository implements ParentCourseRepository {
  final Duration delay;

  MockParentCourseRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<List<CourseEntity>> getCourses(String childId, {String? status}) async {
    await Future.delayed(delay);
    return [
      const CourseEntity(
        id: 'c1',
        title: 'Mathematics Grade 10',
        subtitle: 'Advanced mathematics for grade 10 students.',
        price: 500,
        enrolledCount: 150,
      ),
      const CourseEntity(
        id: 'c2',
        title: 'Physics I',
        subtitle: 'Introductory physics.',
        price: 450,
        enrolledCount: 120,
      ),
    ];
  }

  @override
  Future<CourseSummaryEntity> getCourseProgress(String childId, String courseId) async {
    await Future.delayed(delay);
    return CourseSummaryEntity(
      id: courseId,
      title: 'Mathematics Grade 10',
      thumbnailUrl: '',
      enrolledCount: 150,
      progressPercent: 60.0,
      price: 500.0,
    );
  }
}
