part of 'status_pending_page_bloc.dart';

final class StatusPendingPageState extends Equatable {
  final LoadingState loadingState;

  const StatusPendingPageState({
    required this.loadingState,
  });

  static const initial = StatusPendingPageState(
    loadingState: LoadingState.initial,
  );

  StatusPendingPageState copyWith({
    LoadingState? loadingState,
  }) {
    return StatusPendingPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
