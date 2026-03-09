part of 'status_rejected_page_bloc.dart';

enum StatusRejectedPageStatus { initial, ready }

final class StatusRejectedPageState extends Equatable {
  final StatusRejectedPageStatus status;

  const StatusRejectedPageState({
    this.status = StatusRejectedPageStatus.initial,
  });

  StatusRejectedPageState copyWith({
    StatusRejectedPageStatus? status,
  }) {
    return StatusRejectedPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
