import 'package:mentorx_core/mentorx_core.dart';

final class GetParentNotificationsUseCase {
  final NotificationRepository _repository;

  const GetParentNotificationsUseCase(this._repository);

  Future<List<NotificationEntity>> call({
    MentorXPaginationInfo? paginationInfo,
  }) {
    return _repository.getNotifications(paginationInfo: paginationInfo);
  }
}

final class MarkParentNotificationAsReadUseCase {
  final NotificationRepository _repository;

  const MarkParentNotificationAsReadUseCase(this._repository);

  Future<void> call(String notificationId) {
    return _repository.markAsRead(notificationId);
  }
}

final class MarkAllParentNotificationsAsReadUseCase {
  final NotificationRepository _repository;

  const MarkAllParentNotificationsAsReadUseCase(this._repository);

  Future<void> call() {
    return _repository.markAllAsRead();
  }
}

final class GetParentUnreadNotificationsCountUseCase {
  final NotificationRepository _repository;

  const GetParentUnreadNotificationsCountUseCase(this._repository);

  Future<int> call() {
    return _repository.getUnreadCount();
  }
}
