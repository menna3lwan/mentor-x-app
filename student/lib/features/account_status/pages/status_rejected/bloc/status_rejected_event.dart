part of 'status_rejected_bloc.dart';

sealed class StatusRejectedEvent extends Equatable {
  const StatusRejectedEvent();

  @override
  List<Object?> get props => [];
}

final class StatusRejectedInitialized extends StatusRejectedEvent {
  const StatusRejectedInitialized();
}
