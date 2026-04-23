part of 'shopping_cart_page_bloc.dart';

final class ShoppingCartPageState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? walletSummary;

  const ShoppingCartPageState({
    this.loadingState = LoadingState.initial,
    this.walletSummary,
  });

  static const initial = ShoppingCartPageState();

  @override
  List<Object?> get props => [loadingState, walletSummary];

  ShoppingCartPageState copyWith({
    LoadingState? loadingState,
    WalletSummaryEntity? walletSummary,
  }) {
    return ShoppingCartPageState(
      loadingState: loadingState ?? this.loadingState,
      walletSummary: walletSummary ?? this.walletSummary,
    );
  }
}
