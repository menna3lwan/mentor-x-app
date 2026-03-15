part of 'wallet_main_page_bloc.dart';

sealed class WalletMainPageEvent extends Equatable {
  const WalletMainPageEvent();

  @override
  List<Object?> get props => [];
}

final class WalletMainPageLoadEvent extends WalletMainPageEvent {
  const WalletMainPageLoadEvent();
}
