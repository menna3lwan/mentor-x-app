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
  }) => throw NotificationRepositoryException(code: code, message: message);

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
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);

      return items
          .map((item) => ParentNotificationModel.fromJson(asMap(item)))
          .toList(growable: false);
    } on HttpClientResponse catch (error) {
      return handleHttpClientErrorResponse(
        error,
        defaultCode:
            NotificationRepositoryExceptionCode.failedToLoadNotifications,
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      // Backend contract: PATCH /api/notifications/{id}/read (Postman).
      // Older builds used POST; kept as a fallback when backend returns 405.
      try {
        await _httpClient.patch('/api/notifications/$notificationId/read');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 405) rethrow;
        await _httpClient.post('/api/notifications/$notificationId/read');
      }
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
      // Backend contract: PATCH /api/notifications/read-all (Postman).
      try {
        await _httpClient.patch('/api/notifications/read-all');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 405) rethrow;
        await _httpClient.post('/api/notifications/read-all');
      }
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
        codeFromStatusCode: _classify,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    // API-CONTRACT: DELETE /api/notifications/{id} is not declared in the
    // EduCore Postman collection. Treated as best-effort.
    try {
      await _httpClient.delete('/api/notifications/$notificationId');
    } on HttpClientResponse catch (error) {
      if (error.statusCode == 404 || error.statusCode == 405) return;
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.failedToDelete,
      );
    }
  }

  @override
  Future<void> updateFCMToken(String token) async {
    // API-CONTRACT: /api/notifications/fcm-token is not declared in the
    // EduCore Postman collection. The call is kept for forward-compatibility
    // and silently swallows 404/405 so it cannot break the auth flow.
    try {
      await _httpClient.post(
        '/api/notifications/fcm-token',
        data: {'token': token},
      );
    } on HttpClientResponse catch (error) {
      if (error.statusCode == 404 || error.statusCode == 405) return;
      handleHttpClientErrorResponse(
        error,
        defaultCode: NotificationRepositoryExceptionCode.unknown,
      );
    }
  }

  NotificationRepositoryExceptionCode _classify(int statusCode) {
    return switch (statusCode) {
      401 || 403 => NotificationRepositoryExceptionCode.unauthorized,
      404 => NotificationRepositoryExceptionCode.failedToLoadNotifications,
      _ => NotificationRepositoryExceptionCode.unknown,
    };
  }
}
