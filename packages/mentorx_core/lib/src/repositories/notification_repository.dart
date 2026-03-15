part of '../../mentorx_core.dart';

enum NotificationRepositoryExceptionCode {
  unknown,
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
  /// Fetch paginated notifications.
  Future<List<NotificationEntity>> getNotifications({
    int page = 1,
    int limit = 20,
  });

  /// Mark a single notification as read.
  Future<void> markAsRead(String notificationId);

  /// Mark all notifications as read.
  Future<void> markAllAsRead();

  /// Delete a notification.
  Future<void> deleteNotification(String notificationId);

  /// Get unread notifications count.
  Future<int> getUnreadCount();
}
