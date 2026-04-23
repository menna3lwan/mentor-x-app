import 'package:mentorx_core/mentorx_core.dart';
import 'models/communication_models.dart';
export 'models/communication_models.dart';

final class DioParentCommunicationRepository
    extends HttpClientRepository<ParentCommunicationRepositoryExceptionCode>
    implements ParentCommunicationRepository {
  final HttpClient httpClient;

  DioParentCommunicationRepository({required this.httpClient});

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
        '/api/v1/parent/children/$childId/notifications',
      );

      final data = asList(response.data);
      return data.map((e) => NotificationModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/announcements',
      );

      final data = asList(response.data);
      return data.map((e) => AnnouncementModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/whatsapp-groups',
      );

      final data = asList(response.data);
      return data.map((e) => WhatsAppGroupModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

}
