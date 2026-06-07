part of 'wallet_main_bloc.dart';

final class WalletMainState extends Equatable {
  final LoadingState loadingState;
  final WalletSummaryEntity? summary;
  final List<WalletTransactionEntity> transactions;
  final String? errorMessage;

  const WalletMainState({
    this.loadingState = LoadingState.initial,
    this.summary,
    this.transactions = const [],
    this.errorMessage,
  });

  static const initial = WalletMainState();

  @override
  List<Object?> get props => [
    loadingState,
    summary,
    transactions,
    errorMessage,
  ];

  WalletMainState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<WalletSummaryEntity?>? summary,
    List<WalletTransactionEntity>? transactions,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return WalletMainState(
      loadingState: loadingState ?? this.loadingState,
      summary: summary != null ? summary.value : this.summary,
      transactions: transactions ?? this.transactions,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
