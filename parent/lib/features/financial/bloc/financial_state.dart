part of 'financial_bloc.dart';

enum FinancialSectionStatus { initial, loading, loaded, failure }

enum FinancialSection { transactions, summary, payments, analytics }

final class FinancialAsyncSection<T> extends Equatable {
  final FinancialSectionStatus status;
  final T? data;
  final String? errorMessage;

  const FinancialAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const FinancialAsyncSection.initial()
      : this._(status: FinancialSectionStatus.initial);
  const FinancialAsyncSection.loading({T? data})
      : this._(status: FinancialSectionStatus.loading, data: data);
  const FinancialAsyncSection.loaded(T data)
      : this._(status: FinancialSectionStatus.loaded, data: data);
  const FinancialAsyncSection.failure(String message, {T? data})
      : this._(
          status: FinancialSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == FinancialSectionStatus.initial;
  bool get isLoading => status == FinancialSectionStatus.loading;
  bool get isLoaded => status == FinancialSectionStatus.loaded;
  bool get isFailure => status == FinancialSectionStatus.failure;

  FinancialAsyncSection<T> toLoading() =>
      FinancialAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class FinancialState extends Equatable {
  final String? childId;
  final bool isRefreshing;

  final FinancialAsyncSection<List<WalletTransactionEntity>>
      transactionsSection;
  final FinancialAsyncSection<WalletSummaryEntity> summarySection;
  final FinancialAsyncSection<List<PaymentEntity>> paymentsSection;
  final FinancialAsyncSection<ParentWalletAnalyticsEntity> analyticsSection;

  const FinancialState({
    required this.childId,
    required this.isRefreshing,
    required this.transactionsSection,
    required this.summarySection,
    required this.paymentsSection,
    required this.analyticsSection,
  });

  factory FinancialState.initial() {
    return const FinancialState(
      childId: null,
      isRefreshing: false,
      transactionsSection: FinancialAsyncSection.initial(),
      summarySection: FinancialAsyncSection.initial(),
      paymentsSection: FinancialAsyncSection.initial(),
      analyticsSection: FinancialAsyncSection.initial(),
    );
  }

  List<WalletTransactionEntity> get transactions =>
      transactionsSection.data ?? const <WalletTransactionEntity>[];

  List<PaymentEntity> get paymentMethods =>
      paymentsSection.data ?? const <PaymentEntity>[];

  WalletSummaryEntity? get walletSummary => summarySection.data;
  ParentWalletAnalyticsEntity? get analytics => analyticsSection.data;

  FinancialState copyWith({
    String? childId,
    bool? isRefreshing,
    FinancialAsyncSection<List<WalletTransactionEntity>>? transactionsSection,
    FinancialAsyncSection<WalletSummaryEntity>? summarySection,
    FinancialAsyncSection<List<PaymentEntity>>? paymentsSection,
    FinancialAsyncSection<ParentWalletAnalyticsEntity>? analyticsSection,
  }) {
    return FinancialState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      transactionsSection: transactionsSection ?? this.transactionsSection,
      summarySection: summarySection ?? this.summarySection,
      paymentsSection: paymentsSection ?? this.paymentsSection,
      analyticsSection: analyticsSection ?? this.analyticsSection,
    );
  }

  @override
  List<Object?> get props => [
        childId,
        isRefreshing,
        transactionsSection,
        summarySection,
        paymentsSection,
        analyticsSection,
      ];
}
