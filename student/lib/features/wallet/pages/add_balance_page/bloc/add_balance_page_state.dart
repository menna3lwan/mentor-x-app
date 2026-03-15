part of 'add_balance_page_bloc.dart';

final class AddBalancePageState extends Equatable {
  final LoadingState loadingState;

  const AddBalancePageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AddBalancePageState();

  @override
  List<Object?> get props => [loadingState];

  AddBalancePageState copyWith({LoadingState? loadingState}) {
    return AddBalancePageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
