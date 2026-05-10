part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentCommunicationRepositoryExceptionCode {
  unknown,
  fetchError,
}

final class ParentCommunicationRepositoryException
    extends MentorXException<ParentCommunicationRepositoryExceptionCode> {
  const ParentCommunicationRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentCommunicationRepository {
  Future<void> initialize();
  Future<List<NotificationEntity>> getNotifications(String childId);
  Future<List<AnnouncementEntity>> getAnnouncements(String childId);
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId);
}
