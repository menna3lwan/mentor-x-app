import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockParentHomeRepository implements ParentHomeRepository {
  const MockParentHomeRepository();

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentHomeSummaryEntity> getSummary(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.homeSummary();
  }

  @override
  Future<ParentChildDashboardSummaryEntity> getChildOverview(String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ParentChildDashboardSummaryEntity(
      studentId: studentId,
      studentName: 'Student $studentId',
      grade: 'Grade 10',
      totalAttendance: 10,
      centerAttendance: 8,
      onlineAttendance: 2,
      activeEnrollments: 3,
      completedLessons: 12,
      inProgressLessons: 5,
    );
  }

  @override
  Future<List<ParentRecentActivityEntity>> getRecentActivity(
    String studentId, {
    int limit = 10,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.recentActivity(studentId);
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(
    String studentId, {
    int limit = 3,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.announcements();
  }
}
