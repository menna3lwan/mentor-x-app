import 'package:mentorx_core/mentorx_core.dart';

final class MockStudentCommunicationRepository
    implements StudentCommunicationRepository {
  final Duration delay;

  MockStudentCommunicationRepository({this.delay = const Duration(milliseconds: 500)});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups() async {
    await Future.delayed(delay);
    return const [
      WhatsAppGroupEntity(
        id: '1',
        name: 'Technical Support',
        url: 'https://chat.whatsapp.com/technical',
        description: 'Direct contact with technical support team.',
      ),
      WhatsAppGroupEntity(
        id: '2',
        name: 'Academic Inquiries',
        url: 'https://chat.whatsapp.com/academic',
        description: 'For any questions related to courses and study materials.',
      ),
      WhatsAppGroupEntity(
        id: '3',
        name: 'General Community',
        url: 'https://chat.whatsapp.com/community',
        description: 'Connect with other students and share experiences.',
      ),
    ];
  }
}
