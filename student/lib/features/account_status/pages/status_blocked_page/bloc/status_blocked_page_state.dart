part of 'status_blocked_page_bloc.dart';

enum StatusBlockedPageStatus { initial, ready }

final class StatusBlockedPageState extends Equatable {
  final StatusBlockedPageStatus status;

  const StatusBlockedPageState({
    this.status = StatusBlockedPageStatus.initial,
  });

  StatusBlockedPageState copyWith({
    StatusBlockedPageStatus? status,
  }) {
    return StatusBlockedPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
