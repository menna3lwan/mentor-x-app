part of 'status_blocked_bloc.dart';

final class StatusBlockedState extends Equatable {
  final LoadingState loadingState;

  const StatusBlockedState({
    required this.loadingState,
  });

  static const initial = StatusBlockedState(
    loadingState: LoadingState.initial,
  );

  StatusBlockedState copyWith({
    LoadingState? loadingState,
  }) {
    return StatusBlockedState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
