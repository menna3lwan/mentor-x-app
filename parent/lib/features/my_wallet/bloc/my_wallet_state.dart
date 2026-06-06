part of 'my_wallet_bloc.dart';

enum MyWalletSection { summary, transactions }

enum MyWalletSectionStatus { initial, loading, loaded, failure }

final class MyWalletAsyncSection<T> extends Equatable {
  final MyWalletSectionStatus status;
  final T? data;
  final String? errorMessage;

  const MyWalletAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const MyWalletAsyncSection.initial()
    : this._(status: MyWalletSectionStatus.initial);

  const MyWalletAsyncSection.loading([T? data])
    : this._(status: MyWalletSectionStatus.loading, data: data);

  const MyWalletAsyncSection.loaded(T data)
    : this._(status: MyWalletSectionStatus.loaded, data: data);

  const MyWalletAsyncSection.failure(String message)
    : this._(status: MyWalletSectionStatus.failure, errorMessage: message);

  bool get isInitial => status == MyWalletSectionStatus.initial;
  bool get isLoading => status == MyWalletSectionStatus.loading;
  bool get isLoaded => status == MyWalletSectionStatus.loaded;
  bool get isFailure => status == MyWalletSectionStatus.failure;

  MyWalletAsyncSection<T> toLoading() => MyWalletAsyncSection.loading(data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class MyWalletState extends Equatable {
  final MyWalletAsyncSection<WalletSummaryEntity> summary;
  final MyWalletAsyncSection<List<WalletTransactionEntity>> transactions;
  final bool isRefreshing;

  const MyWalletState({
    required this.summary,
    required this.transactions,
    this.isRefreshing = false,
  });

  factory MyWalletState.initial() => const MyWalletState(
    summary: MyWalletAsyncSection.initial(),
    transactions: MyWalletAsyncSection.initial(),
  );

  MyWalletState copyWith({
    MyWalletAsyncSection<WalletSummaryEntity>? summary,
    MyWalletAsyncSection<List<WalletTransactionEntity>>? transactions,
    bool? isRefreshing,
  }) {
    return MyWalletState(
      summary: summary ?? this.summary,
      transactions: transactions ?? this.transactions,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [summary, transactions, isRefreshing];
}
