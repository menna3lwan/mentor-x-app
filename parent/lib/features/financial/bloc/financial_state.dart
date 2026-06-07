part of 'financial_bloc.dart';

enum FinancialStatus { initial, loading, success, failure }

final class FinancialState extends Equatable {
  final FinancialStatus status;
  final List<WalletTransactionEntity> transactions;
  final List<PaymentEntity> paymentMethods;
  final WalletSummaryEntity? walletSummary;
  final ParentWalletAnalyticsEntity? analytics;
  final String? errorMessage;

  const FinancialState({
    this.status = FinancialStatus.initial,
    this.transactions = const [],
    this.paymentMethods = const [],
    this.walletSummary,
    this.analytics,
    this.errorMessage,
  });

  FinancialState copyWith({
    FinancialStatus? status,
    List<WalletTransactionEntity>? transactions,
    List<PaymentEntity>? paymentMethods,
    WalletSummaryEntity? walletSummary,
    ParentWalletAnalyticsEntity? analytics,
    String? errorMessage,
  }) {
    return FinancialState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      walletSummary: walletSummary ?? this.walletSummary,
      analytics: analytics ?? this.analytics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        paymentMethods,
        walletSummary,
        analytics,
        errorMessage,
      ];
}
