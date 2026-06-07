part of 'notifications_bloc.dart';

final class NotificationsState extends Equatable {
  final LoadingState loadingState;
  final List<NotificationEntity> notifications;
  final String? errorMessage;
  final bool hasMore;
  final int currentPage;

  const NotificationsState({
    this.loadingState = LoadingState.initial,
    this.notifications = const [],
    this.errorMessage,
    this.hasMore = true,
    this.currentPage = 0,
  });

  static const initial = NotificationsState();

  @override
  List<Object?> get props => [
    loadingState,
    notifications,
    errorMessage,
    hasMore,
    currentPage,
  ];

  NotificationsState copyWith({
    LoadingState? loadingState,
    List<NotificationEntity>? notifications,
    MentorXNullableValue<String?>? errorMessage,
    bool? hasMore,
    int? currentPage,
  }) {
    return NotificationsState(
      loadingState: loadingState ?? this.loadingState,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
