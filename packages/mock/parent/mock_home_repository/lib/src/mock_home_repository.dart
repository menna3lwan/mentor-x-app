import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockParentHomeRepository implements ParentHomeRepository {
  const MockParentHomeRepository();

  @override
  Future<
    List<
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >
  >
  getStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.stats();
  }

  @override
  Future<List<({String subject, double performance})>>
  getSubjectPerformance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.subjectPerformance();
  }

  @override
  Future<List<({String title, String date, int iconCodePoint})>>
  getRecentAchievements() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.recentAchievements();
  }

  @override
  Future<String> getAiInsight() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.aiInsight();
  }
}
