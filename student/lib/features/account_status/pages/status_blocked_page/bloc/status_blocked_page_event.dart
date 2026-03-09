part of 'status_blocked_page_bloc.dart';

sealed class StatusBlockedPageEvent extends Equatable {
  const StatusBlockedPageEvent();

  @override
  List<Object?> get props => [];
}

final class StatusBlockedPageInitialized extends StatusBlockedPageEvent {
  const StatusBlockedPageInitialized();
}
