part of 'add_balance_page_bloc.dart';

final class AddBalancePageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const AddBalancePageState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = AddBalancePageState();

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;
  bool get isSubmitting => loadingState == LoadingState.loading;

  @override
  List<Object?> get props => [loadingState, errorMessage];

  AddBalancePageState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return AddBalancePageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
