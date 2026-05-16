part of 'wallet_orders_page_bloc.dart';

final class WalletOrdersPageState extends Equatable {
  final LoadingState loadingState;
  final List<PaymentOrderEntity> orders;
  final String? errorMessage;

  const WalletOrdersPageState({
    this.loadingState = LoadingState.initial,
    this.orders = const [],
    this.errorMessage,
  });

  static const initial = WalletOrdersPageState();

  @override
  List<Object?> get props => [loadingState, orders, errorMessage];

  WalletOrdersPageState copyWith({
    LoadingState? loadingState,
    List<PaymentOrderEntity>? orders,
    String? errorMessage,
  }) {
    return WalletOrdersPageState(
      loadingState: loadingState ?? this.loadingState,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
