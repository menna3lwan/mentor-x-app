part of 'marketplace_orders_page_bloc.dart';

sealed class MarketplaceOrdersPageEvent extends Equatable {
  const MarketplaceOrdersPageEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceOrdersPageInitialized extends MarketplaceOrdersPageEvent {
  const MarketplaceOrdersPageInitialized();
}

final class MarketplaceOrdersPageRefreshed extends MarketplaceOrdersPageEvent {
  const MarketplaceOrdersPageRefreshed();
}
