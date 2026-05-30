import 'package:mentorx_core/mentorx_core.dart';

import 'models/parent_notification_model.dart';

export 'models/parent_notification_model.dart';

final class DioParentNotificationRepository
    extends HttpClientRepository<NotificationRepositoryExceptionCode>
    implements NotificationRepository {
  final HttpClient _httpClient;

  const DioParentNotificationRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    NotificationRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw NotificationRepositoryException(code: code, message: message);

  @override
  Future<List<NotificationEntity>> getNotifications({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/notifications/my',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final responseMap = asMap(response.data);
      final payload = responseMap['data'] ?? response.data;
      final items = payload is Map ? asList(payload['content']) : asList(payload);

      return items
          .map((item) => ParentNotificationModel.fromJson(asMap(item)))
          .toList(growable: false);
    } on HttpClientResponse catch (error) {
      return handleHttpClientErrorResponse(
        error,
        defaultCode:
            NotificationRepositoryExceptionCode.failedToLoadNotifications,
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _httpClient.post('/api/notifications/$notificationId/read');
    } on HttpClientResponse catch (error) {
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.failedToMarkAsRead,
      );
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await _httpClient.post('/api/notifications/read-all');
    } on HttpClientResponse catch (error) {
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.failedToMarkAllAsRead,
      );
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final response = await _httpClient.get('/api/notifications/unread-count');
      final data = asMap(response.data)['data'] ?? response.data;
      if (data is num) return data.toInt();
      if (data is Map) {
        return ModelParser.asInt(data['count'] ?? data['unreadCount']);
      }
      return 0;
    } on HttpClientResponse catch (error) {
      return handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.failedToGetUnreadCount,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _httpClient.delete('/api/notifications/$notificationId');
    } on HttpClientResponse catch (error) {
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.failedToDelete,
      );
    }
  }

  @override
  Future<void> updateFCMToken(String token) async {
    try {
      await _httpClient.post(
        '/api/notifications/fcm-token',
        data: {'token': token},
      );
    } on HttpClientResponse catch (error) {
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.unknown,
      );
    }
  }
}
