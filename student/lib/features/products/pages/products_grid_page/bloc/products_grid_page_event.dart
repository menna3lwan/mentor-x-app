part of 'products_grid_page_bloc.dart';

sealed class ProductsGridPageEvent extends Equatable {
  const ProductsGridPageEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsGridPageLoadEvent extends ProductsGridPageEvent {
  const ProductsGridPageLoadEvent();
}

final class ProductsGridPageCategorySelectedEvent extends ProductsGridPageEvent {
  final String? categoryId;

  const ProductsGridPageCategorySelectedEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

final class ProductsGridPageSearchQueryChangedEvent extends ProductsGridPageEvent {
  final String searchQuery;

  const ProductsGridPageSearchQueryChangedEvent(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}
