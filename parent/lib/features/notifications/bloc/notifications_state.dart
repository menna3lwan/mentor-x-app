part of 'notifications_bloc.dart';

final class NotificationsState extends Equatable {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final int page;
  final bool hasMore;
  final bool isLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool isMarkingAllRead;
  final String? errorMessage;

  const NotificationsState({
    required this.notifications,
    required this.unreadCount,
    required this.page,
    required this.hasMore,
    required this.isLoading,
    required this.isRefreshing,
    required this.isLoadingMore,
    required this.isMarkingAllRead,
    this.errorMessage,
  });

  factory NotificationsState.initial() {
    return const NotificationsState(
      notifications: [],
      unreadCount: 0,
      page: 1,
      hasMore: true,
      isLoading: false,
      isRefreshing: false,
      isLoadingMore: false,
      isMarkingAllRead: false,
    );
  }

  NotificationsState copyWith({
    List<NotificationEntity>? notifications,
    int? unreadCount,
    int? page,
    bool? hasMore,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    bool? isMarkingAllRead,
    String? errorMessage,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isMarkingAllRead: isMarkingAllRead ?? this.isMarkingAllRead,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    notifications,
    unreadCount,
    page,
    hasMore,
    isLoading,
    isRefreshing,
    isLoadingMore,
    isMarkingAllRead,
    errorMessage,
  ];
}
