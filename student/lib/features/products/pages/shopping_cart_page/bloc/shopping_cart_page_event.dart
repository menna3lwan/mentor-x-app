part of 'shopping_cart_page_bloc.dart';

sealed class ShoppingCartPageEvent extends Equatable {
  const ShoppingCartPageEvent();

  @override
  List<Object?> get props => [];
}

final class ShoppingCartPageLoadEvent extends ShoppingCartPageEvent {
  const ShoppingCartPageLoadEvent();
}
