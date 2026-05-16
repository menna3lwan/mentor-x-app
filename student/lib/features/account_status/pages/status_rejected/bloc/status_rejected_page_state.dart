part of 'status_rejected_page_bloc.dart';

final class StatusRejectedPageState extends Equatable {
  final LoadingState loadingState;

  const StatusRejectedPageState({
    required this.loadingState,
  });

  static const initial = StatusRejectedPageState(
    loadingState: LoadingState.initial,
  );

  StatusRejectedPageState copyWith({
    LoadingState? loadingState,
  }) {
    return StatusRejectedPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
