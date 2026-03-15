part of 'product_detail_page_bloc.dart';

final class ProductDetailPageState extends Equatable {
  final LoadingState loadingState;

  const ProductDetailPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ProductDetailPageState();

  @override
  List<Object?> get props => [loadingState];

  ProductDetailPageState copyWith({LoadingState? loadingState}) {
    return ProductDetailPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
