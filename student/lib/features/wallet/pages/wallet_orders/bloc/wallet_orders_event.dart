part of 'wallet_orders_bloc.dart';

sealed class WalletOrdersEvent extends Equatable {
  const WalletOrdersEvent();

  @override
  List<Object> get props => [];
}

final class WalletOrdersLoadEvent extends WalletOrdersEvent {
  const WalletOrdersLoadEvent();
}
