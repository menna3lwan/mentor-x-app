part of 'marketplace_orders_page_bloc.dart';

final class MarketplaceOrdersPageState extends Equatable {
  final LoadingState loadingState;
  final List<MarketplaceOrderEntity> orders;
  final String? errorMessage;

  const MarketplaceOrdersPageState({
    required this.loadingState,
    required this.orders,
    this.errorMessage,
  });

  static const initial = MarketplaceOrdersPageState(
    loadingState: LoadingState.initial,
    orders: <MarketplaceOrderEntity>[],
  );

  MarketplaceOrdersPageState copyWith({
    LoadingState? loadingState,
    List<MarketplaceOrderEntity>? orders,
    String? errorMessage,
  }) {
    return MarketplaceOrdersPageState(
      loadingState: loadingState ?? this.loadingState,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;

  @override
  List<Object?> get props => [loadingState, orders, errorMessage];
}
