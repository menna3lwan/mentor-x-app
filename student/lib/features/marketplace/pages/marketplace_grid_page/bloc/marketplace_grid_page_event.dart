part of 'marketplace_grid_page_bloc.dart';

sealed class MarketplaceGridPageEvent extends Equatable {
  const MarketplaceGridPageEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceGridPageLoadEvent extends MarketplaceGridPageEvent {
  const MarketplaceGridPageLoadEvent();
}

final class MarketplaceGridPageCategorySelectedEvent extends MarketplaceGridPageEvent {
  final String? categoryId;

  const MarketplaceGridPageCategorySelectedEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

final class MarketplaceGridPageSearchQueryChangedEvent extends MarketplaceGridPageEvent {
  final String searchQuery;

  const MarketplaceGridPageSearchQueryChangedEvent(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}
