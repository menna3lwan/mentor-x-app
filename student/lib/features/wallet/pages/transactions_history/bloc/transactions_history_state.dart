part of 'transactions_history_bloc.dart';

final class TransactionsHistoryState extends Equatable {
  final LoadingState loadingState;
  final List<WalletTransactionEntity> transactions;
  final String? errorMessage;
  final bool hasMore;
  final int currentPage;

  const TransactionsHistoryState({
    this.loadingState = LoadingState.initial,
    this.transactions = const [],
    this.errorMessage,
    this.hasMore = true,
    this.currentPage = 0,
  });

  static const initial = TransactionsHistoryState();

  @override
  List<Object?> get props => [
    loadingState,
    transactions,
    errorMessage,
    hasMore,
    currentPage,
  ];

  TransactionsHistoryState copyWith({
    LoadingState? loadingState,
    List<WalletTransactionEntity>? transactions,
    MentorXNullableValue<String?>? errorMessage,
    bool? hasMore,
    int? currentPage,
  }) {
    return TransactionsHistoryState(
      loadingState: loadingState ?? this.loadingState,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
