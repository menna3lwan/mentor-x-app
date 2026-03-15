part of 'transactions_history_page_bloc.dart';

sealed class TransactionsHistoryPageEvent extends Equatable {
  const TransactionsHistoryPageEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionsHistoryPageLoadEvent
    extends TransactionsHistoryPageEvent {
  const TransactionsHistoryPageLoadEvent();
}
