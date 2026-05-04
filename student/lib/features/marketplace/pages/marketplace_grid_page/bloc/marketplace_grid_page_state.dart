part of 'marketplace_grid_page_bloc.dart';

final class MarketplaceGridPageState extends Equatable {
  final LoadingState loadingState;
  final List<MarketplaceItemEntity> items;
  final List<MarketplaceCategoryEntity> categories;
  final String? selectedCategoryId;
  final String searchQuery;

  const MarketplaceGridPageState({
    this.loadingState = LoadingState.initial,
    this.items = const [],
    this.categories = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
  });

  static const initial = MarketplaceGridPageState();

  @override
  List<Object?> get props => [
        loadingState,
        items,
        categories,
        selectedCategoryId,
        searchQuery,
      ];

  MarketplaceGridPageState copyWith({
    LoadingState? loadingState,
    List<MarketplaceItemEntity>? items,
    List<MarketplaceCategoryEntity>? categories,
    String? Function()? selectedCategoryId,
    String? searchQuery,
  }) {
    return MarketplaceGridPageState(
      loadingState: loadingState ?? this.loadingState,
      items: items ?? this.items,
      categories: categories ?? this.categories,
      selectedCategoryId:
          selectedCategoryId != null ? selectedCategoryId() : this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
