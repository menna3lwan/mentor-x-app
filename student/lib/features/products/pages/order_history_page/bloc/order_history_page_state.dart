part of 'order_history_page_bloc.dart';

final class OrderHistoryPageState extends Equatable {
  final LoadingState loadingState;
  final List<MarketplaceOrderEntity> orders;
  final String? errorMessage;

  const OrderHistoryPageState({
    required this.loadingState,
    required this.orders,
    this.errorMessage,
  });

  static const initial = OrderHistoryPageState(
    loadingState: LoadingState.initial,
    orders: <MarketplaceOrderEntity>[],
  );

  OrderHistoryPageState copyWith({
    LoadingState? loadingState,
    List<MarketplaceOrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrderHistoryPageState(
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
