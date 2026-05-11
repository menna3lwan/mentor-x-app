part of 'package:mentorx_core/mentorx_core.dart';

enum StudentHomeRepositoryExceptionCode {
  unknown,
  failedToLoadWalletSummary,
  failedToLoadUnreadNotificationsCount,
  failedToLoadBanners,
  failedToLoadContinueLearning,
  failedToLoadFeaturedCourses,
  failedToLoadAnnouncements,
  failedToTrackBannerClick,
}

final class StudentHomeRepositoryException
    extends MentorXException<StudentHomeRepositoryExceptionCode> {
  StudentHomeRepositoryException({required super.code, super.message});
}

abstract interface class StudentHomeRepository {
  Future<void> initialize();

  Future<WalletSummaryEntity> getWalletSummary();

  Future<int> getUnreadNotificationsCount();

  Future<List<BannerEntity>> getHomeBanners({String? gradeId});

  Future<List<CourseSummaryEntity>> getContinueLearningCourses();

  Future<List<CourseSummaryEntity>> getFeaturedCourses({String? gradeId});

  Future<List<AnnouncementEntity>> getRecentAnnouncements();

  Future<void> trackBannerClick(String bannerId);

  // Pro Features
  Future<BannerEntity> createBanner(Map<String, dynamic> data);
  Future<void> updateBanner(String bannerId, Map<String, dynamic> data);
  Future<void> deleteBanner(String bannerId);
}
