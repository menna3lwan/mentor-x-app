part of 'status_pending_page_bloc.dart';

sealed class StatusPendingPageEvent extends Equatable {
  const StatusPendingPageEvent();

  @override
  List<Object?> get props => [];
}

final class StatusPendingPageInitialized extends StatusPendingPageEvent {
  const StatusPendingPageInitialized();
}

final class StatusPendingPageRefreshRequested extends StatusPendingPageEvent {
  final bool isManual;

  const StatusPendingPageRefreshRequested({this.isManual = false});

  @override
  List<Object?> get props => [isManual];
}

final class StatusPendingPageLogoutRequested extends StatusPendingPageEvent {
  const StatusPendingPageLogoutRequested();
}
