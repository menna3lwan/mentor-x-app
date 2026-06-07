part of 'splash_bloc.dart';

final class SplashState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const SplashState({
    required this.loadingState,
    this.errorMessage,
  });

  static const initial = SplashState(loadingState: LoadingState.initial);

  SplashState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return SplashState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadingState, errorMessage];
}
