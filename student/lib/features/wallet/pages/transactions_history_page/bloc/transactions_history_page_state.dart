part of 'transactions_history_page_bloc.dart';

final class TransactionsHistoryPageState extends Equatable {
  final LoadingState loadingState;

  const TransactionsHistoryPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = TransactionsHistoryPageState();

  @override
  List<Object?> get props => [loadingState];

  TransactionsHistoryPageState copyWith({LoadingState? loadingState}) {
    return TransactionsHistoryPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
