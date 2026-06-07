part of 'shell_bloc.dart';

final class ShellState extends Equatable {
  final LoadingState loadingState;

  const ShellState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ShellState();

  @override
  List<Object?> get props => [loadingState];

  ShellState copyWith({LoadingState? loadingState}) {
    return ShellState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
