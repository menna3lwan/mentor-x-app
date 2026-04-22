part of 'shopping_cart_page_bloc.dart';

sealed class ShoppingCartPageEvent extends Equatable {
  const ShoppingCartPageEvent();

  @override
  List<Object?> get props => [];
}

final class ShoppingCartPageLoadEvent extends ShoppingCartPageEvent {
  const ShoppingCartPageLoadEvent();
}

final class ShoppingCartPagePlaceOrderEvent extends ShoppingCartPageEvent {
  final List<({String itemId, int quantity})> items;
  final String address;
  final String phone;

  const ShoppingCartPagePlaceOrderEvent({
    required this.items,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props => [items, address, phone];
}
