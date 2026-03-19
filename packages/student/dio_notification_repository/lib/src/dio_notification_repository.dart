import 'package:mentorx_core/mentorx_core.dart';
import '../models/notification_model.dart';

final class DioNotificationRepository
    extends HttpClientRepository<NotificationRepositoryExceptionCode>
    implements NotificationRepository {
  @override
  Never throwException(NotificationRepositoryExceptionCode code,
          {String? message}) =>
      throw NotificationRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioNotificationRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<NotificationEntity>> getNotifications({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/notifications',
      queryParameters: {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      },
    );

    if (response.statusCode != 200) {
      throw NotificationRepositoryException(
        code: NotificationRepositoryExceptionCode.failedToLoadNotifications,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final response = await httpClient.post('/api/notifications/$notificationId/read');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw NotificationRepositoryException(
        code: NotificationRepositoryExceptionCode.failedToMarkAsRead,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<void> markAllAsRead() async {
    final response = await httpClient.post('/api/notifications/read-all');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw NotificationRepositoryException(
        code: NotificationRepositoryExceptionCode.failedToMarkAllAsRead,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final response = await httpClient.delete('/api/notifications/$notificationId');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw NotificationRepositoryException(
        code: NotificationRepositoryExceptionCode.failedToDelete,
        message: response.exception?.message,
      );
    }
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await httpClient.get('/api/notifications/unread-count');

    if (response.statusCode != 200) {
      throw NotificationRepositoryException(
        code: NotificationRepositoryExceptionCode.failedToGetUnreadCount,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    return (data['count'] ?? data as num?)?.toInt() ?? 0;
  }
}
