part of 'marketplace_grid_bloc.dart';

sealed class MarketplaceGridEvent extends Equatable {
  const MarketplaceGridEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceGridLoadEvent extends MarketplaceGridEvent {
  const MarketplaceGridLoadEvent();
}

final class MarketplaceGridCategorySelectedEvent
    extends MarketplaceGridEvent {
  final String? categoryId;

  const MarketplaceGridCategorySelectedEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

final class MarketplaceGridSearchQueryChangedEvent
    extends MarketplaceGridEvent {
  final String searchQuery;

  const MarketplaceGridSearchQueryChangedEvent(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}
