part of '../../mock_data.dart';

final class MockNotificationGenerator {
  MockNotificationGenerator._();

  static List<NotificationEntity> notifications() {
    final now = DateTime.now();
    return [
      NotificationEntity(
        id: 'n1',
        type: NotificationType.announcement,
        title: 'New Announcement',
        message:
            'Tomorrow Session Time Updated — The physics live class has been moved to 7:00 PM.',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      NotificationEntity(
        id: 'n2',
        type: NotificationType.quiz,
        title: 'New Quiz Available',
        message:
            'A new algebra quiz has been published. Complete it before the deadline.',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      NotificationEntity(
        id: 'n3',
        type: NotificationType.info,
        title: 'Wallet Topped Up',
        message:
            'Your wallet has been credited with 500.00 EGP via Vodafone Cash.',
        isRead: true,
        readAt: now.subtract(const Duration(hours: 4)),
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      NotificationEntity(
        id: 'n4',
        type: NotificationType.info,
        title: 'Assignment Graded',
        message:
            'Your assignment "Linear Equations" has been graded. Score: 85/100.',
        isRead: false,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      NotificationEntity(
        id: 'n5',
        type: NotificationType.course,
        title: 'Course Enrollment Confirmed',
        message: 'You have been enrolled in "Advanced Algebra for Grade 10".',
        isRead: true,
        readAt: now.subtract(const Duration(days: 1)),
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      NotificationEntity(
        id: 'n6',
        type: NotificationType.info,
        title: 'Attendance Marked',
        message:
            "Your attendance has been marked as present for today's Physics class.",
        isRead: true,
        readAt: now.subtract(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      NotificationEntity(
        id: 'n7',
        type: NotificationType.system,
        title: 'Welcome to MentorX',
        message:
            'Welcome! Start exploring courses and boost your learning journey.',
        isRead: true,
        readAt: now.subtract(const Duration(days: 5)),
        createdAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  static int unreadCount() => 3;
}
