part of 'marketplace_detail_bloc.dart';

final class MarketplaceDetailState extends Equatable {
  final LoadingState loadingState;
  final MarketplaceItemEntity? item;

  const MarketplaceDetailState({
    this.loadingState = LoadingState.initial,
    this.item,
  });

  static const initial = MarketplaceDetailState();

  @override
  List<Object?> get props => [loadingState, item];

  MarketplaceDetailState copyWith({
    LoadingState? loadingState,
    MarketplaceItemEntity? item,
  }) {
    return MarketplaceDetailState(
      loadingState: loadingState ?? this.loadingState,
      item: item ?? this.item,
    );
  }
}
