part of 'products_grid_page_bloc.dart';

final class ProductsGridPageState extends Equatable {
  final LoadingState loadingState;
  final List<MarketplaceItemEntity> items;
  final List<MarketplaceCategoryEntity> categories;
  final String? selectedCategoryId;
  final String searchQuery;

  const ProductsGridPageState({
    this.loadingState = LoadingState.initial,
    this.items = const [],
    this.categories = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
  });

  static const initial = ProductsGridPageState();

  @override
  List<Object?> get props => [
        loadingState,
        items,
        categories,
        selectedCategoryId,
        searchQuery,
      ];

  ProductsGridPageState copyWith({
    LoadingState? loadingState,
    List<MarketplaceItemEntity>? items,
    List<MarketplaceCategoryEntity>? categories,
    String? Function()? selectedCategoryId,
    String? searchQuery,
  }) {
    return ProductsGridPageState(
      loadingState: loadingState ?? this.loadingState,
      items: items ?? this.items,
      categories: categories ?? this.categories,
      selectedCategoryId:
          selectedCategoryId != null ? selectedCategoryId() : this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
