part of 'marketplace_detail_bloc.dart';

sealed class MarketplaceDetailEvent extends Equatable {
  const MarketplaceDetailEvent();

  @override
  List<Object?> get props => [];
}

final class MarketplaceDetailLoadEvent extends MarketplaceDetailEvent {
  final String itemId;

  const MarketplaceDetailLoadEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
