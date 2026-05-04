part of 'wallet_orders_page_bloc.dart';

sealed class WalletOrdersPageEvent extends Equatable {
  const WalletOrdersPageEvent();

  @override
  List<Object> get props => [];
}

final class WalletOrdersPageLoadEvent extends WalletOrdersPageEvent {
  const WalletOrdersPageLoadEvent();
}
