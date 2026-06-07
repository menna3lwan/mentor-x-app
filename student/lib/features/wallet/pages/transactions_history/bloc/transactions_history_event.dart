part of 'transactions_history_bloc.dart';

sealed class TransactionsHistoryEvent extends Equatable {
  const TransactionsHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionsHistoryLoadEvent
    extends TransactionsHistoryEvent {
  const TransactionsHistoryLoadEvent();
}

final class TransactionsHistoryLoadMoreEvent
    extends TransactionsHistoryEvent {
  const TransactionsHistoryLoadMoreEvent();
}
