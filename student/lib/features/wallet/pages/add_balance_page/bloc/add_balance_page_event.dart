part of 'add_balance_page_bloc.dart';

sealed class AddBalancePageEvent extends Equatable {
  const AddBalancePageEvent();

  @override
  List<Object?> get props => [];
}

final class AddBalancePageLoadEvent extends AddBalancePageEvent {
  const AddBalancePageLoadEvent();
}

final class AddBalancePageSubmitEvent extends AddBalancePageEvent {
  final double amount;
  final PaymentMethod method;

  const AddBalancePageSubmitEvent({
    required this.amount,
    required this.method,
  });

  @override
  List<Object?> get props => [amount, method];
}
