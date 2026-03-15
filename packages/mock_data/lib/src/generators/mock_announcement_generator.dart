import 'package:mentorx_core/mentorx_core.dart';

final class MockAnnouncementGenerator {
  MockAnnouncementGenerator._();

  static List<AnnouncementEntity> announcements() {
    final now = DateTime.now();
    return [
      AnnouncementEntity(
        id: 'ann1',
        title: 'Tomorrow Session Time Updated',
        preview:
            'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance.',
        createdAt: now.subtract(const Duration(hours: 2)),
        isPinned: true,
      ),
      AnnouncementEntity(
        id: 'ann2',
        title: 'New Quiz Available',
        preview:
            'A new algebra quiz has been published and will stay open for 48 hours starting now.',
        createdAt: now.subtract(const Duration(hours: 6)),
        isPinned: false,
      ),
      AnnouncementEntity(
        id: 'ann3',
        title: 'Wallet Bonus Campaign',
        preview:
            'Top up your wallet this week and receive bonus points that can be exchanged for rewards.',
        createdAt: now.subtract(const Duration(days: 1)),
        isPinned: false,
      ),
      AnnouncementEntity(
        id: 'ann4',
        title: 'Exam Schedule Released',
        preview:
            'The midterm exam schedule has been published. Check your courses for specific dates and times.',
        createdAt: now.subtract(const Duration(days: 2)),
        isPinned: true,
      ),
      AnnouncementEntity(
        id: 'ann5',
        title: 'Holiday Notice',
        preview:
            'MentorX wishes all students a happy Eid holiday. Classes resume on Sunday.',
        createdAt: now.subtract(const Duration(days: 5)),
        isPinned: false,
      ),
    ];
  }

  static AnnouncementEntity announcementDetail(String id) {
    return AnnouncementEntity(
      id: id,
      title: 'Tomorrow Session Time Updated',
      preview:
          'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance. The homework for the previous session should also be submitted before class.',
      imageUrl: 'https://picsum.photos/800/400?announcement',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isPinned: true,
    );
  }
}
