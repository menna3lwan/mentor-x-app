import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockNotificationRepository implements NotificationRepository {
  final Duration delay;

  const MockNotificationRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<NotificationEntity>> getNotifications({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockNotificationGenerator.notifications();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<void> markAllAsRead() async {
    await Future<void>.delayed(delay ~/ 2);
  }


  @override
  Future<int> getUnreadCount() async {
    await Future<void>.delayed(delay ~/ 2);
    return MockNotificationGenerator.unreadCount();
  }

  @override
  Future<void> updateFCMToken(String token) async {
    await Future<void>.delayed(delay ~/ 2);
  }
}
