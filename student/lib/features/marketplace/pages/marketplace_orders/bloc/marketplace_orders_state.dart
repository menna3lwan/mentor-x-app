part of 'marketplace_orders_bloc.dart';

final class MarketplaceOrdersState extends Equatable {
  final LoadingState loadingState;
  final List<MarketplaceOrderEntity> orders;
  final String? errorMessage;

  const MarketplaceOrdersState({
    required this.loadingState,
    required this.orders,
    this.errorMessage,
  });

  static const initial = MarketplaceOrdersState(
    loadingState: LoadingState.initial,
    orders: <MarketplaceOrderEntity>[],
  );

  MarketplaceOrdersState copyWith({
    LoadingState? loadingState,
    List<MarketplaceOrderEntity>? orders,
    String? errorMessage,
  }) {
    return MarketplaceOrdersState(
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
