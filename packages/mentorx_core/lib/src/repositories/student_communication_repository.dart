part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum StudentCommunicationRepositoryExceptionCode {
  unknown,
  failedToLoadWhatsAppGroups,
}

final class StudentCommunicationRepositoryException
    extends MentorXException<StudentCommunicationRepositoryExceptionCode> {
  const StudentCommunicationRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class StudentCommunicationRepository {
  Future<void> initialize();
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups();
}
