import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'product_detail_page_event.dart';
part 'product_detail_page_state.dart';

sealed class ProductDetailPagePresentationEvent {
  const ProductDetailPagePresentationEvent();
}

final class ProductDetailPageNavigateBack
    extends ProductDetailPagePresentationEvent {
  const ProductDetailPageNavigateBack();
}

final class ProductDetailPageBloc
    extends Bloc<ProductDetailPageEvent, ProductDetailPageState>
    with
        BlocPresentationMixin<
          ProductDetailPageState,
          ProductDetailPagePresentationEvent
        > {
  ProductDetailPageBloc({required this.marketplaceRepository})
    : super(ProductDetailPageState.initial) {
    on<ProductDetailPageLoadEvent>(_onLoad);
  }

  final MarketplaceRepository marketplaceRepository;

  Future<void> _onLoad(
    ProductDetailPageLoadEvent event,
    Emitter<ProductDetailPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
