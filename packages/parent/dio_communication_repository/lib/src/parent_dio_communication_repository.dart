import 'package:mentorx_core/mentorx_core.dart';
import 'models/communication_models.dart';

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
    const defaultException = ParentCommunicationRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/notifications',
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(String childId) async {
    const defaultException = ParentCommunicationRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/announcements',
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => AnnouncementModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId) async {
    const defaultException = ParentCommunicationRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/whatsapp-groups',
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => WhatsAppGroupModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }
}
