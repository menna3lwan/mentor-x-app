part of 'marketplace_cart_page_bloc.dart';

final class MarketplaceCartPageState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? walletSummary;

  const MarketplaceCartPageState({
    this.loadingState = LoadingState.initial,
    this.walletSummary,
  });

  static const initial = MarketplaceCartPageState();

  @override
  List<Object?> get props => [loadingState, walletSummary];

  MarketplaceCartPageState copyWith({
    LoadingState? loadingState,
    WalletSummaryEntity? walletSummary,
  }) {
    return MarketplaceCartPageState(
      loadingState: loadingState ?? this.loadingState,
      walletSummary: walletSummary ?? this.walletSummary,
    );
  }
}
