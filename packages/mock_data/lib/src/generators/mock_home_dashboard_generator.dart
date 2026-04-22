part of '../../mock_data.dart';

final class MockHomeDashboardGenerator {
  MockHomeDashboardGenerator._();

  static WalletSummaryEntity walletSummary() {
    return const WalletSummaryEntity(
        walletBalance: 1240.5, points: 860);
  }

  static int unreadNotificationsCount() => 4;

  static List<BannerEntity> banners() {
    return const [
      BannerEntity(
        id: 'b1',
        imageUrl: 'https://picsum.photos/800/450?1',
        title: 'New Revision Marathon',
        deepLink: 'mentorx://course/course_1',
      ),
      BannerEntity(
        id: 'b2',
        imageUrl: 'https://picsum.photos/800/450?2',
        title: 'Limited Offer for New Courses',
        deepLink: 'mentorx://catalog',
      ),
      BannerEntity(
        id: 'b3',
        imageUrl: 'https://picsum.photos/800/450?3',
        title: 'Attendance Rewards Week',
        deepLink: 'mentorx://rewards',
      ),
    ];
  }

  static List<CourseSummaryEntity> continueLearningCourses() {
    return const [
      CourseSummaryEntity(
        id: 'c1',
        title: 'Advanced Algebra for Grade 10',
        thumbnailUrl: 'https://picsum.photos/500/300?11',
        progressPercent: 64,
        enrolledCount: 1270,
      ),
      CourseSummaryEntity(
        id: 'c2',
        title: 'Physics Mechanics — Midterm Revision',
        thumbnailUrl: 'https://picsum.photos/500/300?12',
        progressPercent: 38,
        enrolledCount: 950,
      ),
      CourseSummaryEntity(
        id: 'c3',
        title: 'English Grammar Essentials',
        thumbnailUrl: 'https://picsum.photos/500/300?13',
        progressPercent: 81,
        enrolledCount: 780,
      ),
    ];
  }

  static List<CourseSummaryEntity> featuredCourses() {
    return const [
      CourseSummaryEntity(
        id: 'f1',
        title: 'Chemistry Crash Course',
        thumbnailUrl: 'https://picsum.photos/400/400?21',
        price: 300,
        enrolledCount: 2190,
      ),
      CourseSummaryEntity(
        id: 'f2',
        title: 'Biology Question Bank',
        thumbnailUrl: 'https://picsum.photos/400/400?22',
        price: 0,
        enrolledCount: 1320,
      ),
      CourseSummaryEntity(
        id: 'f3',
        title: 'Math Final Exam Prep',
        thumbnailUrl: 'https://picsum.photos/400/400?23',
        price: 260,
        enrolledCount: 1705,
      ),
      CourseSummaryEntity(
        id: 'f4',
        title: 'Arabic Writing Masterclass',
        thumbnailUrl: 'https://picsum.photos/400/400?24',
        price: 0,
        enrolledCount: 905,
      ),
    ];
  }

  static List<AnnouncementEntity> announcements() {
    final now = DateTime.now();
    return [
      AnnouncementEntity(
        id: 'a1',
        title: 'Tomorrow Session Time Updated',
        content: 'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance.',
        preview: 'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance.',
        createdAt: now.subtract(const Duration(hours: 2)),
        isPinned: true,
      ),
      AnnouncementEntity(
        id: 'a2',
        title: 'New Quiz Available',
        content: 'A new algebra quiz has been published and will stay open for 48 hours starting now.',
        preview: 'A new algebra quiz has been published and will stay open for 48 hours starting now.',
        createdAt: now.subtract(const Duration(hours: 6)),
        isPinned: false,
      ),
      AnnouncementEntity(
        id: 'a3',
        title: 'Wallet Bonus Campaign',
        content: 'Top up your wallet this week and receive bonus points that can be exchanged for rewards.',
        preview: 'Top up your wallet this week and receive bonus points that can be exchanged for rewards.',
        createdAt: now.subtract(const Duration(days: 1)),
        isPinned: false,
      ),
    ];
  }
}
