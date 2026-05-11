import 'package:mentorx_core/mentorx_core.dart';

final class MockParentCommunicationRepository implements ParentCommunicationRepository {
  final Duration delay;

  MockParentCommunicationRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<List<NotificationEntity>> getNotifications(String childId) async {
    await Future.delayed(delay);
    return [
      NotificationEntity(
        id: 'n1',
        title: 'Grade Published',
        message: 'Mathematics midterm grade is now available.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        type: NotificationType.quiz,
      ),
    ];
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(String childId) async {
    await Future.delayed(delay);
    return [
      AnnouncementEntity(
        id: 'a1',
        title: 'Center Holiday',
        content: 'The center will be closed next Monday for public holiday.',
        preview: 'The center will be closed next Monday for public holiday.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        imageUrl: null,
      ),
    ];
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId) async {
    await Future.delayed(delay);
    return [
      const WhatsAppGroupEntity(
        id: 'w1',
        name: 'Math Grade 10 Support',
        url: 'https://chat.whatsapp.com/example1',
      ),
    ];
  }
}
