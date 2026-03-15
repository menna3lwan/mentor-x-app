part of 'products_grid_page_bloc.dart';

sealed class ProductsGridPageEvent extends Equatable {
  const ProductsGridPageEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsGridPageLoadEvent extends ProductsGridPageEvent {
  const ProductsGridPageLoadEvent();
}
