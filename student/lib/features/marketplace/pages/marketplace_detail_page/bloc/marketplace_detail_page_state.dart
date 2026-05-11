part of 'marketplace_detail_page_bloc.dart';

final class MarketplaceDetailPageState extends Equatable {
  final LoadingState loadingState;
  final MarketplaceItemEntity? item;

  const MarketplaceDetailPageState({
    this.loadingState = LoadingState.initial,
    this.item,
  });

  static const initial = MarketplaceDetailPageState();

  @override
  List<Object?> get props => [loadingState, item];

  MarketplaceDetailPageState copyWith({
    LoadingState? loadingState,
    MarketplaceItemEntity? item,
  }) {
    return MarketplaceDetailPageState(
      loadingState: loadingState ?? this.loadingState,
      item: item ?? this.item,
    );
  }
}
