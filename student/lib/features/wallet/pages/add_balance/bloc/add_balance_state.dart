part of 'add_balance_bloc.dart';

final class AddBalanceState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const AddBalanceState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = AddBalanceState();

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;
  bool get isSubmitting => loadingState == LoadingState.loading;

  @override
  List<Object?> get props => [loadingState, errorMessage];

  AddBalanceState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return AddBalanceState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
