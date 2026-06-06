part of 'my_wallet_bloc.dart';

sealed class MyWalletEvent extends Equatable {
  const MyWalletEvent();

  @override
  List<Object?> get props => const [];
}

final class MyWalletStarted extends MyWalletEvent {
  const MyWalletStarted();
}

final class MyWalletRefreshRequested extends MyWalletEvent {
  const MyWalletRefreshRequested();
}

final class MyWalletRetrySectionRequested extends MyWalletEvent {
  final MyWalletSection section;
  const MyWalletRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
