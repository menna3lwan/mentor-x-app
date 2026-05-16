part of 'payment_success_page_bloc.dart';

sealed class PaymentSuccessPageEvent extends Equatable {
  const PaymentSuccessPageEvent();

  @override
  List<Object?> get props => [];
}

final class PaymentSuccessPageLoadEvent extends PaymentSuccessPageEvent {
  const PaymentSuccessPageLoadEvent();
}
