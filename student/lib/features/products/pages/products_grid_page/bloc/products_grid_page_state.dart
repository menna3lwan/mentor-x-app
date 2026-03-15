part of 'products_grid_page_bloc.dart';

final class ProductsGridPageState extends Equatable {
  final LoadingState loadingState;

  const ProductsGridPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ProductsGridPageState();

  @override
  List<Object?> get props => [loadingState];

  ProductsGridPageState copyWith({LoadingState? loadingState}) {
    return ProductsGridPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
