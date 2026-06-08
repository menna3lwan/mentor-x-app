import 'package:mentorx_core/mentorx_core.dart';
import 'models/notification_model.dart';
export 'models/notification_model.dart';

final class DioNotificationRepository
    extends HttpClientRepository<NotificationRepositoryExceptionCode>
    implements NotificationRepository {
  @override
  Never throwException(
    NotificationRepositoryExceptionCode code, {
    String? message,
  }) => throw NotificationRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioNotificationRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<NotificationEntity>> getNotifications({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/notifications/my',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list.map((e) => NotificationModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            NotificationRepositoryExceptionCode.failedToLoadNotifications,
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await httpClient.patch('/api/notifications/$notificationId/read');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: NotificationRepositoryExceptionCode.failedToMarkAsRead,
      );
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await httpClient.patch('/api/notifications/read-all');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: NotificationRepositoryExceptionCode.failedToMarkAllAsRead,
      );
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final response = await httpClient.get('/api/notifications/unread-count');
      final data = response.asMap();
      return ModelParser.asInt(data['unreadCount'] ?? data['count']);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: NotificationRepositoryExceptionCode.failedToGetUnreadCount,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await httpClient.delete('/api/notifications/$notificationId');
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
    try {
      await httpClient.post(
        '/api/notifications/fcm-token',
        data: {'token': token},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: NotificationRepositoryExceptionCode.unknown,
      );
    }
  }
}
