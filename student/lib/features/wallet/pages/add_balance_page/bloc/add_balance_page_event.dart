part of 'add_balance_page_bloc.dart';

sealed class AddBalancePageEvent extends Equatable {
  const AddBalancePageEvent();

  @override
  List<Object?> get props => [];
}

final class AddBalancePageLoadEvent extends AddBalancePageEvent {
  const AddBalancePageLoadEvent();
}
