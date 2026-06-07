part of 'purchase_confirm_bloc.dart';

sealed class PurchaseConfirmEvent extends Equatable {
  const PurchaseConfirmEvent();

  @override
  List<Object?> get props => [];
}

final class PurchaseConfirmLoadEvent extends PurchaseConfirmEvent {
  final String paymentId;
  const PurchaseConfirmLoadEvent({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}
