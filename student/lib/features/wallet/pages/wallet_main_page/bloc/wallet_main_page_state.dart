part of 'wallet_main_page_bloc.dart';

final class WalletMainPageState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? summary;
  final List<WalletTransactionEntity> transactions;
  final String? errorMessage;

  const WalletMainPageState({
    this.loadingState = LoadingState.initial,
    this.summary,
    this.transactions = const [],
    this.errorMessage,
  });

  static const initial = WalletMainPageState();

  @override
  List<Object?> get props => [
    loadingState,
    summary,
    transactions,
    errorMessage,
  ];

  WalletMainPageState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<WalletSummaryEntity?>? summary,
    List<WalletTransactionEntity>? transactions,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return WalletMainPageState(
      loadingState: loadingState ?? this.loadingState,
      summary: summary != null ? summary.value : this.summary,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
