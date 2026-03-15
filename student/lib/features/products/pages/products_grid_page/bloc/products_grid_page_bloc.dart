import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'products_grid_page_event.dart';
part 'products_grid_page_state.dart';

sealed class ProductsGridPagePresentationEvent {
  const ProductsGridPagePresentationEvent();
}

final class ProductsGridPageNavigateBack
    extends ProductsGridPagePresentationEvent {
  const ProductsGridPageNavigateBack();
}

final class ProductsGridPageBloc
    extends Bloc<ProductsGridPageEvent, ProductsGridPageState>
    with
        BlocPresentationMixin<
          ProductsGridPageState,
          ProductsGridPagePresentationEvent
        > {
  ProductsGridPageBloc({required this.marketplaceRepository})
    : super(ProductsGridPageState.initial) {
    on<ProductsGridPageLoadEvent>(_onLoad);
  }

  final MarketplaceRepository marketplaceRepository;

  Future<void> _onLoad(
    ProductsGridPageLoadEvent event,
    Emitter<ProductsGridPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
