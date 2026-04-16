part of 'financial_bloc.dart';

final class FinancialState extends Equatable {
  final bool isLoading;
  final String filter;
  final List<ParentFinancialTransaction> transactions;
  final String? errorMessage;

  const FinancialState({
    this.isLoading = false,
    this.filter = 'all',
    this.transactions = const [],
    this.errorMessage,
  });

  double get currentBalance =>
      transactions.isEmpty ? 0.0 : transactions.first.balanceAfter;

  FinancialState copyWith({
    bool? isLoading,
    String? filter,
    List<ParentFinancialTransaction>? transactions,
    String? errorMessage,
  }) {
    return FinancialState(
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, filter, transactions, errorMessage];
}
