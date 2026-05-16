part of 'add_balance_page_bloc.dart';

final class AddBalancePageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;
  final PaymentEntity? payment;

  const AddBalancePageState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
    this.payment,
  });

  static const initial = AddBalancePageState();

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;
  bool get isSubmitting => loadingState == LoadingState.loading;

  @override
  List<Object?> get props => [loadingState, errorMessage, payment];

  AddBalancePageState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
    PaymentEntity? payment,
  }) {
    return AddBalancePageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
      payment: payment ?? this.payment,
    );
  }
}
