import 'package:mentorx_core/mentorx_core.dart';
import 'models/communication_models.dart';
export 'models/communication_models.dart';

final class DioParentCommunicationRepository
    extends HttpClientRepository<ParentCommunicationRepositoryExceptionCode>
    implements ParentCommunicationRepository {
  final HttpClient _httpClient;

  DioParentCommunicationRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentCommunicationRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentCommunicationRepositoryException(
          code: code, message: message);

  // ─────────────────────────────────────────────────────────────────────────
  // API-CONTRACT (KNOWN MISMATCH):
  // /api/parent/children/{id}/notifications, /announcements, /whatsapp-groups
  // are NOT declared in the EduCore Postman collection. The closest backend
  // endpoints are the generic /api/notifications/my and
  // /api/announcements/active. The methods below first try the per-child
  // path (older builds), then fall back to the generic ones. WhatsApp groups
  // are not exposed by backend at all and degrade to an empty list.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<NotificationEntity>> getNotifications(String childId) async {
    try {
      HttpClientResponse response;
      try {
        response = await _httpClient.get(
          '/api/parent/children/$childId/notifications',
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await _httpClient.get('/api/notifications/my');
      }

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items.map((e) => NotificationModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <NotificationEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<AnnouncementEntity>> getAnnouncements(String childId) async {
    try {
      HttpClientResponse response;
      try {
        response = await _httpClient.get(
          '/api/parent/children/$childId/announcements',
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await _httpClient.get('/api/announcements/active');
      }

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items
          .map((e) => AnnouncementModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <AnnouncementEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups(String childId) async {
    // API-CONTRACT: WhatsApp groups are not exposed by the backend.
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/whatsapp-groups',
      );

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items
          .map((e) => WhatsAppGroupModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <WhatsAppGroupEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentCommunicationRepositoryExceptionCode.fetchError,
      );
    }
  }
}
