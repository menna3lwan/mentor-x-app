part of 'shell_page_bloc.dart';

final class ShellPageState extends Equatable {
  final LoadingState loadingState;

  const ShellPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ShellPageState();

  @override
  List<Object?> get props => [loadingState];

  ShellPageState copyWith({LoadingState? loadingState}) {
    return ShellPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
