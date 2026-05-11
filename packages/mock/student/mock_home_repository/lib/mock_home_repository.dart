import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockHomeRepository implements StudentHomeRepository {
  final Duration delay;

  const MockHomeRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<WalletSummaryEntity> getWalletSummary() async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.walletSummary();
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    await Future<void>.delayed(delay ~/ 2);
    return MockHomeDashboardGenerator.unreadNotificationsCount();
  }

  @override
  Future<List<BannerEntity>> getHomeBanners(
      {String? gradeId}) async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.banners();
  }

  @override
  Future<List<CourseSummaryEntity>> getContinueLearningCourses() async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.continueLearningCourses();
  }

  @override
  Future<List<CourseSummaryEntity>> getFeaturedCourses(
      {String? gradeId}) async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.featuredCourses();
  }

  @override
  Future<List<AnnouncementEntity>> getRecentAnnouncements() async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.announcements();
  }

  @override
  Future<void> trackBannerClick(String bannerId) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<BannerEntity> createBanner(Map<String, dynamic> data) async {
    await Future<void>.delayed(delay);
    return MockHomeDashboardGenerator.banners().first;
  }

  @override
  Future<void> updateBanner(String bannerId, Map<String, dynamic> data) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<void> deleteBanner(String bannerId) async {
    await Future<void>.delayed(delay);
  }
}
