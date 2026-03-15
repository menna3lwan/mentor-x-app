part of 'purchase_confirm_page_bloc.dart';

final class PurchaseConfirmPageState extends Equatable {
  final LoadingState loadingState;

  const PurchaseConfirmPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = PurchaseConfirmPageState();

  @override
  List<Object?> get props => [loadingState];

  PurchaseConfirmPageState copyWith({LoadingState? loadingState}) {
    return PurchaseConfirmPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
