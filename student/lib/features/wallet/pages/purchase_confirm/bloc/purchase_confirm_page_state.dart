part of 'purchase_confirm_page_bloc.dart';

final class PurchaseConfirmPageState extends Equatable {
  final LoadingState loadingState;
  final PaymentEntity? payment;
  final String? errorMessage;
  final String? paymentId;

  const PurchaseConfirmPageState({
    this.loadingState = LoadingState.initial,
    this.payment,
    this.errorMessage,
    this.paymentId,
  });

  static const initial = PurchaseConfirmPageState();

  @override
  List<Object?> get props => [loadingState, payment, errorMessage, paymentId];

  PurchaseConfirmPageState copyWith({
    LoadingState? loadingState,
    PaymentEntity? payment,
    String? errorMessage,
    String? paymentId,
  }) {
    return PurchaseConfirmPageState(
      loadingState: loadingState ?? this.loadingState,
      payment: payment ?? this.payment,
      errorMessage: errorMessage ?? this.errorMessage,
      paymentId: paymentId ?? this.paymentId,
    );
  }
}
