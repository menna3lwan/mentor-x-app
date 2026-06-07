part of 'status_blocked_bloc.dart';

sealed class StatusBlockedEvent extends Equatable {
  const StatusBlockedEvent();

  @override
  List<Object?> get props => [];
}

final class StatusBlockedInitialized extends StatusBlockedEvent {
  const StatusBlockedInitialized();
}
