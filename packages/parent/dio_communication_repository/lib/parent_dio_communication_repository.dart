import 'package:mentorx_core/mentorx_core.dart';
import 'models/communication_models.dart';
export 'models/communication_models.dart';

final class DioParentCommunicationRepository
    extends HttpClientRepository<ParentCommunicationRepositoryExceptionCode>
    implements ParentCommunicationRepository {
  final HttpClient httpClient;

  DioParentCommunicationRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentCommunicationRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentCommunicationRepositoryException(code: code, message: message);
  }

  @override
  Future<List<NotificationEntity>> getNotifications(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/notifications',
      );

      final data = asList(response.data);
      return data.map((e) => NotificationModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/announcements',
      );

      final data = asList(response.data);
      return data.map((e) => AnnouncementModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/parent/dashboard/child/$childId/whatsapp-groups',
      );

      final data = asList(response.data);
      return data.map((e) => WhatsAppGroupModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }
}
