part of 'notifications_page_bloc.dart';

final class NotificationsPageState extends Equatable {
  final LoadingState loadingState;

  const NotificationsPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = NotificationsPageState();

  @override
  List<Object?> get props => [loadingState];

  NotificationsPageState copyWith({LoadingState? loadingState}) {
    return NotificationsPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
