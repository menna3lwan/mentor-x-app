part of 'transactions_history_page_bloc.dart';

final class TransactionsHistoryPageState extends Equatable {
  final LoadingState loadingState;
  final List<WalletTransactionEntity> transactions;
  final String? errorMessage;
  final bool hasMore;
  final int currentPage;

  const TransactionsHistoryPageState({
    this.loadingState = LoadingState.initial,
    this.transactions = const [],
    this.errorMessage,
    this.hasMore = true,
    this.currentPage = 0,
  });

  static const initial = TransactionsHistoryPageState();

  @override
  List<Object?> get props => [
        loadingState,
        transactions,
        errorMessage,
        hasMore,
        currentPage,
      ];

  TransactionsHistoryPageState copyWith({
    LoadingState? loadingState,
    List<WalletTransactionEntity>? transactions,
    MentorXNullableValue<String?>? errorMessage,
    bool? hasMore,
    int? currentPage,
  }) {
    return TransactionsHistoryPageState(
      loadingState: loadingState ?? this.loadingState,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
