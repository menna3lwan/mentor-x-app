part of 'walkthrough_page_bloc.dart';

final class WalkthroughPageState extends Equatable {
  final LoadingState loadingState;

  const WalkthroughPageState({
    required this.loadingState,
  });

  static const initial = WalkthroughPageState(
    loadingState: LoadingState.initial,
  );

  bool get isSubmitting => loadingState.isLoading;

  WalkthroughPageState copyWith({
    LoadingState? loadingState,
  }) {
    return WalkthroughPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object?> get props => [loadingState];
}
