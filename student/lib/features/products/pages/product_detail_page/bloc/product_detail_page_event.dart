part of 'product_detail_page_bloc.dart';

sealed class ProductDetailPageEvent extends Equatable {
  const ProductDetailPageEvent();

  @override
  List<Object?> get props => [];
}

final class ProductDetailPageLoadEvent extends ProductDetailPageEvent {
  const ProductDetailPageLoadEvent();
}
