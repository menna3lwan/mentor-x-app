part of 'walkthrough_bloc.dart';

final class WalkthroughState extends Equatable {
  final LoadingState loadingState;

  const WalkthroughState({
    required this.loadingState,
  });

  static const initial = WalkthroughState(
    loadingState: LoadingState.initial,
  );

  bool get isSubmitting => loadingState.isLoading;

  WalkthroughState copyWith({
    LoadingState? loadingState,
  }) {
    return WalkthroughState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
