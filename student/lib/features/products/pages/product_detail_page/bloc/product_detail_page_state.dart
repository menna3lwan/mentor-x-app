part of 'product_detail_page_bloc.dart';

final class ProductDetailPageState extends Equatable {
  final LoadingState loadingState;
  final MarketplaceItemEntity? item;

  const ProductDetailPageState({
    this.loadingState = LoadingState.initial,
    this.item,
  });

  static const initial = ProductDetailPageState();

  @override
  List<Object?> get props => [loadingState, item];

  ProductDetailPageState copyWith({
    LoadingState? loadingState,
    MarketplaceItemEntity? item,
  }) {
    return ProductDetailPageState(
      loadingState: loadingState ?? this.loadingState,
      item: item ?? this.item,
    );
  }
}
