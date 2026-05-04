part of 'marketplace_detail_page_bloc.dart';

sealed class MarketplaceDetailPageEvent extends Equatable {
  const MarketplaceDetailPageEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceDetailPageLoadEvent extends MarketplaceDetailPageEvent {
  final String itemId;

  const MarketplaceDetailPageLoadEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
