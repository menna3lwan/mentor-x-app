part of 'purchase_confirm_page_bloc.dart';

final class PurchaseConfirmPageState extends Equatable {
  final LoadingState loadingState;
  final PaymentEntity? payment;
  final String? errorMessage;

  const PurchaseConfirmPageState({
    this.loadingState = LoadingState.initial,
    this.payment,
    this.errorMessage,
  });

  static const initial = PurchaseConfirmPageState();

  @override
  List<Object?> get props => [loadingState, payment, errorMessage];

  PurchaseConfirmPageState copyWith({
    LoadingState? loadingState,
    PaymentEntity? payment,
    String? errorMessage,
  }) {
    return PurchaseConfirmPageState(
      loadingState: loadingState ?? this.loadingState,
      payment: payment ?? this.payment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
