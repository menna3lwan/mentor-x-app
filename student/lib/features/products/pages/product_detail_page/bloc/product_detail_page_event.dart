part of 'product_detail_page_bloc.dart';

sealed class ProductDetailPageEvent extends Equatable {
  const ProductDetailPageEvent();

  @override
  List<Object?> get props => [];
}

final class ProductDetailPageLoadEvent extends ProductDetailPageEvent {
  final String itemId;

  const ProductDetailPageLoadEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
