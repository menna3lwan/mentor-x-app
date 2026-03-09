part of 'status_pending_page_bloc.dart';

enum StatusPendingPageStatus { initial, ready }

final class StatusPendingPageState extends Equatable {
  final StatusPendingPageStatus status;

  const StatusPendingPageState({
    this.status = StatusPendingPageStatus.initial,
  });

  StatusPendingPageState copyWith({
    StatusPendingPageStatus? status,
  }) {
    return StatusPendingPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
