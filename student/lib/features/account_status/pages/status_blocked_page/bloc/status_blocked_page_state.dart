part of 'status_blocked_page_bloc.dart';

final class StatusBlockedPageState extends Equatable {
  final LoadingState loadingState;

  const StatusBlockedPageState({
    required this.loadingState,
  });

  static const initial = StatusBlockedPageState(
    loadingState: LoadingState.initial,
  );

  StatusBlockedPageState copyWith({
    LoadingState? loadingState,
  }) {
    return StatusBlockedPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
