import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockParentHomeRepository implements ParentHomeRepository {
  const MockParentHomeRepository();

  @override
  Future<List<({String title, String value, String subtitle, int colorValue, IconData icon})>> getStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.stats();
  }

  @override
  Future<List<({String subject, double performance})>> getSubjectPerformance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.subjectPerformance();
  }

  @override
  Future<List<({String title, String date, IconData icon})>> getRecentAchievements() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.recentAchievements();
  }

  @override
  Future<String> getAiInsight() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockParentDashboardGenerator.aiInsight();
  }
}
