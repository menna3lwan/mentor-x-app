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
