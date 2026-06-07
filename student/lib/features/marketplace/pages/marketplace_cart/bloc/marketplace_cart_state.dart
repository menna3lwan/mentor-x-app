part of 'marketplace_cart_bloc.dart';

final class MarketplaceCartState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? walletSummary;
  final List<CouponEntity> validCoupons;

  const MarketplaceCartState({
    this.loadingState = LoadingState.initial,
    this.walletSummary,
    this.validCoupons = const [],
  });

  static const initial = MarketplaceCartState();

  @override
  List<Object?> get props => [loadingState, walletSummary, validCoupons];

  MarketplaceCartState copyWith({
    LoadingState? loadingState,
    WalletSummaryEntity? walletSummary,
    List<CouponEntity>? validCoupons,
  }) {
    return MarketplaceCartState(
      loadingState: loadingState ?? this.loadingState,
      walletSummary: walletSummary ?? this.walletSummary,
      validCoupons: validCoupons ?? this.validCoupons,
    );
  }
}
