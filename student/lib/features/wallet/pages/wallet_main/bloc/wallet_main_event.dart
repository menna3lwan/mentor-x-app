part of 'wallet_main_bloc.dart';

sealed class WalletMainEvent extends Equatable {
  const WalletMainEvent();

  @override
  List<Object?> get props => [];
}

final class WalletMainLoadEvent extends WalletMainEvent {
  const WalletMainLoadEvent();
}
