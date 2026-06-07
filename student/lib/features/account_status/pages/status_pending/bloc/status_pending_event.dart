part of 'status_pending_bloc.dart';

sealed class StatusPendingEvent extends Equatable {
  const StatusPendingEvent();

  @override
  List<Object?> get props => [];
}

final class StatusPendingInitialized extends StatusPendingEvent {
  const StatusPendingInitialized();
}

final class StatusPendingRefreshRequested extends StatusPendingEvent {
  final bool isManual;

  const StatusPendingRefreshRequested({this.isManual = false});

  @override
  List<Object?> get props => [isManual];
}

final class StatusPendingLogoutRequested extends StatusPendingEvent {
  const StatusPendingLogoutRequested();
}
