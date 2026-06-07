part of 'wallet_orders_bloc.dart';

final class WalletOrdersState extends Equatable {
  final LoadingState loadingState;
  final List<PaymentOrderEntity> orders;
  final String? errorMessage;

  const WalletOrdersState({
    this.loadingState = LoadingState.initial,
    this.orders = const [],
    this.errorMessage,
  });

  static const initial = WalletOrdersState();

  @override
  List<Object?> get props => [loadingState, orders, errorMessage];

  WalletOrdersState copyWith({
    LoadingState? loadingState,
    List<PaymentOrderEntity>? orders,
    String? errorMessage,
  }) {
    return WalletOrdersState(
      loadingState: loadingState ?? this.loadingState,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
