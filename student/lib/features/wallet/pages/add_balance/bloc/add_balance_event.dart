part of 'add_balance_bloc.dart';

sealed class AddBalanceEvent extends Equatable {
  const AddBalanceEvent();

  @override
  List<Object?> get props => [];
}

final class AddBalanceLoadEvent extends AddBalanceEvent {
  const AddBalanceLoadEvent();
}

final class AddBalanceSubmitEvent extends AddBalanceEvent {
  final double amount;
  final PaymentMethod method;

  const AddBalanceSubmitEvent({
    required this.amount,
    required this.method,
  });

  @override
  List<Object?> get props => [amount, method];
}
