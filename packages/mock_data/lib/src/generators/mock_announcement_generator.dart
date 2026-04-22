part of '../../mock_data.dart';

final class MockAnnouncementGenerator {
  MockAnnouncementGenerator._();

  static List<AnnouncementEntity> announcements() {
    final now = DateTime.now();
    return [
      AnnouncementEntity(
        id: 'ann1',
        title: 'Tomorrow Session Time Updated',
        content: 'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance.',
        preview: 'The physics live class has been moved to 7:00 PM.',
        createdAt: now.subtract(const Duration(hours: 2)),
        isPinned: true,
      ),
      AnnouncementEntity(
        id: 'ann2',
        title: 'New Quiz Available',
        content: 'A new algebra quiz has been published and will stay open for 48 hours starting now.',
        preview: 'A new algebra quiz has been published.',
        createdAt: now.subtract(const Duration(hours: 6)),
        isPinned: false,
      ),
      AnnouncementEntity(
        id: 'ann3',
        title: 'Wallet Bonus Campaign',
        content: 'Top up your wallet this week and receive bonus points that can be exchanged for rewards.',
        preview: 'Top up your wallet this week and receive bonus points.',
        createdAt: now.subtract(const Duration(days: 1)),
        isPinned: false,
      ),
      AnnouncementEntity(
        id: 'ann4',
        title: 'Exam Schedule Released',
        content: 'The midterm exam schedule has been published. Check your courses for specific dates and times.',
        preview: 'The midterm exam schedule has been published.',
        createdAt: now.subtract(const Duration(days: 2)),
        isPinned: true,
      ),
      AnnouncementEntity(
        id: 'ann5',
        title: 'Holiday Notice',
        content: 'MentorX wishes all students a happy Eid holiday. Classes resume on Sunday.',
        preview: 'MentorX wishes all students a happy Eid holiday.',
        createdAt: now.subtract(const Duration(days: 5)),
        isPinned: false,
      ),
    ];
  }

  static AnnouncementEntity announcementDetail(String id) {
    return AnnouncementEntity(
      id: id,
      title: 'Tomorrow Session Time Updated',
      content: 'The physics live class has been moved to 7:00 PM. Please join 10 minutes earlier for attendance. The homework for the previous session should also be submitted before class.',
      preview: 'The physics live class has been moved to 7:00 PM.',
      imageUrl: 'https://picsum.photos/800/400?announcement',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isPinned: true,
    );
  }
}
