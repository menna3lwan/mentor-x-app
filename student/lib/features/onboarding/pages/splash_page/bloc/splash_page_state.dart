part of 'splash_page_bloc.dart';

final class SplashPageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const SplashPageState({
    required this.loadingState,
    this.errorMessage,
  });

  static const initial = SplashPageState(loadingState: LoadingState.initial);

  SplashPageState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return SplashPageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadingState, errorMessage];
}
