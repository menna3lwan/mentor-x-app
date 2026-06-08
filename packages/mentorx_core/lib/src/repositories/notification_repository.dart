part of 'package:mentorx_core/mentorx_core.dart';

enum NotificationRepositoryExceptionCode {
  unknown,
  unauthorized,
  failedToLoadNotifications,
  failedToMarkAsRead,
  failedToMarkAllAsRead,
  failedToDelete,
  failedToGetUnreadCount,
}

final class NotificationRepositoryException
    extends MentorXException<NotificationRepositoryExceptionCode> {
  NotificationRepositoryException({required super.code, super.message});
}

abstract interface class NotificationRepository {
  Future<void> initialize();

  /// Fetch paginated notifications.
  Future<List<NotificationEntity>> getNotifications({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Mark a single notification as read.
  Future<void> markAsRead(String notificationId);

  /// Mark all notifications as read.
  Future<void> markAllAsRead();

  /// Delete a notification.
  Future<void> deleteNotification(String notificationId);

  /// Get unread notifications count.
  Future<int> getUnreadCount();

  /// Update FCM token.
  Future<void> updateFCMToken(String token);
}
