part of 'payment_success_bloc.dart';

sealed class PaymentSuccessEvent extends Equatable {
  const PaymentSuccessEvent();

  @override
  List<Object?> get props => [];
}

final class PaymentSuccessLoadEvent extends PaymentSuccessEvent {
  const PaymentSuccessLoadEvent();
}
