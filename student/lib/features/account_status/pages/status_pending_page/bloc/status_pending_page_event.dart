part of 'status_pending_page_bloc.dart';

sealed class StatusPendingPageEvent extends Equatable {
  const StatusPendingPageEvent();

  @override
  List<Object?> get props => [];
}

final class StatusPendingPageInitialized extends StatusPendingPageEvent {
  const StatusPendingPageInitialized();
}
