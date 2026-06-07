part of 'purchase_confirm_bloc.dart';

final class PurchaseConfirmState extends Equatable {
  final LoadingState loadingState;
  final PaymentEntity? payment;
  final String? errorMessage;
  final String? paymentId;

  const PurchaseConfirmState({
    this.loadingState = LoadingState.initial,
    this.payment,
    this.errorMessage,
    this.paymentId,
  });

  static const initial = PurchaseConfirmState();

  @override
  List<Object?> get props => [loadingState, payment, errorMessage, paymentId];

  PurchaseConfirmState copyWith({
    LoadingState? loadingState,
    PaymentEntity? payment,
    String? errorMessage,
    String? paymentId,
  }) {
    return PurchaseConfirmState(
      loadingState: loadingState ?? this.loadingState,
      payment: payment ?? this.payment,
      errorMessage: errorMessage ?? this.errorMessage,
      paymentId: paymentId ?? this.paymentId,
    );
  }
}
