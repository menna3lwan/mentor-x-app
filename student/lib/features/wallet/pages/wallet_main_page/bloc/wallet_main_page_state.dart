part of 'wallet_main_page_bloc.dart';

final class WalletMainPageState extends Equatable {
  final LoadingState loadingState;

  const WalletMainPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = WalletMainPageState();

  @override
  List<Object?> get props => [loadingState];

  WalletMainPageState copyWith({LoadingState? loadingState}) {
    return WalletMainPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
