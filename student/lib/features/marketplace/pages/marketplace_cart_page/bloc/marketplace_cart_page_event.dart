part of 'marketplace_cart_page_bloc.dart';

sealed class MarketplaceCartPageEvent extends Equatable {
  const MarketplaceCartPageEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceCartPageLoadEvent extends MarketplaceCartPageEvent {
  const MarketplaceCartPageLoadEvent();
}

final class MarketplaceCartPagePlaceOrderEvent
    extends MarketplaceCartPageEvent {
  final List<({String itemId, int quantity})> items;
  final String address;
  final String phone;

  const MarketplaceCartPagePlaceOrderEvent({
    required this.items,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props => [items, address, phone];
}
