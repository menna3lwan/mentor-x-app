part of 'shopping_cart_page_bloc.dart';

final class ShoppingCartPageState extends Equatable {
  final LoadingState loadingState;

  const ShoppingCartPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ShoppingCartPageState();

  @override
  List<Object?> get props => [loadingState];

  ShoppingCartPageState copyWith({LoadingState? loadingState}) {
    return ShoppingCartPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
