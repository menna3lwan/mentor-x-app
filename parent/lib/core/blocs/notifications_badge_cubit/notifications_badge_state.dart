part of 'notifications_badge_cubit.dart';

final class NotificationsBadgeState extends Equatable {
  final int count;
  final bool isLoading;
  final String? errorMessage;

  const NotificationsBadgeState({
    required this.count,
    required this.isLoading,
    this.errorMessage,
  });

  factory NotificationsBadgeState.initial() {
    return const NotificationsBadgeState(count: 0, isLoading: false);
  }

  NotificationsBadgeState copyWith({
    int? count,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotificationsBadgeState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [count, isLoading, errorMessage];
}
