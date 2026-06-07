part of 'status_rejected_bloc.dart';

final class StatusRejectedState extends Equatable {
  final LoadingState loadingState;

  const StatusRejectedState({
    required this.loadingState,
  });

  static const initial = StatusRejectedState(
    loadingState: LoadingState.initial,
  );

  StatusRejectedState copyWith({
    LoadingState? loadingState,
  }) {
    return StatusRejectedState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
