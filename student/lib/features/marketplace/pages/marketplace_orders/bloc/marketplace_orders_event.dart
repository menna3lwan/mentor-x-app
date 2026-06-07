part of 'marketplace_orders_bloc.dart';

sealed class MarketplaceOrdersEvent extends Equatable {
  const MarketplaceOrdersEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceOrdersInitialized
    extends MarketplaceOrdersEvent {
  const MarketplaceOrdersInitialized();
}

final class MarketplaceOrdersRefreshed extends MarketplaceOrdersEvent {
  const MarketplaceOrdersRefreshed();
}
