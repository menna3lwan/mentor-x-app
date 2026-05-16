part of 'status_rejected_page_bloc.dart';

sealed class StatusRejectedPageEvent extends Equatable {
  const StatusRejectedPageEvent();

  @override
  List<Object?> get props => [];
}

final class StatusRejectedPageInitialized extends StatusRejectedPageEvent {
  const StatusRejectedPageInitialized();
}
