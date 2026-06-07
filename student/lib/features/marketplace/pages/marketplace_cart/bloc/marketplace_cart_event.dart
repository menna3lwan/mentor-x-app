part of 'marketplace_cart_bloc.dart';

sealed class MarketplaceCartEvent extends Equatable {
  const MarketplaceCartEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceCartLoadEvent extends MarketplaceCartEvent {
  const MarketplaceCartLoadEvent();
}

final class MarketplaceCartPlaceOrderEvent
    extends MarketplaceCartEvent {
  final List<({String itemId, int quantity})> items;
  final String address;
  final String phone;

  const MarketplaceCartPlaceOrderEvent({
    required this.items,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props => [items, address, phone];
}
