part of 'marketplace_cart_page_bloc.dart';

final class MarketplaceCartPageState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? walletSummary;
  final List<CouponEntity> validCoupons;

  const MarketplaceCartPageState({
    this.loadingState = LoadingState.initial,
    this.walletSummary,
    this.validCoupons = const [],
  });

  static const initial = MarketplaceCartPageState();

  @override
  List<Object?> get props => [loadingState, walletSummary, validCoupons];

  MarketplaceCartPageState copyWith({
    LoadingState? loadingState,
    WalletSummaryEntity? walletSummary,
    List<CouponEntity>? validCoupons,
  }) {
    return MarketplaceCartPageState(
      loadingState: loadingState ?? this.loadingState,
      walletSummary: walletSummary ?? this.walletSummary,
      validCoupons: validCoupons ?? this.validCoupons,
    );
  }
}
