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
        body:
            'Tomorrow Session Time Updated — The physics live class has been moved to 7:00 PM.',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      NotificationEntity(
        id: 'n2',
        type: NotificationType.quizResult,
        title: 'New Quiz Available',
        body:
            'A new algebra quiz has been published. Complete it before the deadline.',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      NotificationEntity(
        id: 'n3',
        type: NotificationType.walletUpdated,
        title: 'Wallet Topped Up',
        body:
            'Your wallet has been credited with 500.00 EGP via Vodafone Cash.',
        isRead: true,
        readAt: now.subtract(const Duration(hours: 4)),
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      NotificationEntity(
        id: 'n4',
        type: NotificationType.assignmentGraded,
        title: 'Assignment Graded',
        body:
            'Your assignment "Linear Equations" has been graded. Score: 85/100.',
        isRead: false,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      NotificationEntity(
        id: 'n5',
        type: NotificationType.courseEnrolled,
        title: 'Course Enrollment Confirmed',
        body: 'You have been enrolled in "Advanced Algebra for Grade 10".',
        isRead: true,
        readAt: now.subtract(const Duration(days: 1)),
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      NotificationEntity(
        id: 'n6',
        type: NotificationType.attendanceMarked,
        title: 'Attendance Marked',
        body:
            "Your attendance has been marked as present for today's Physics class.",
        isRead: true,
        readAt: now.subtract(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      NotificationEntity(
        id: 'n7',
        type: NotificationType.system,
        title: 'Welcome to MentorX',
        body:
            'Welcome! Start exploring courses and boost your learning journey.',
        isRead: true,
        readAt: now.subtract(const Duration(days: 5)),
        createdAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  static int unreadCount() => 3;
}
