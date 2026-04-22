import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
    on<ProductsGridPageCategorySelectedEvent>(_onCategorySelected);
    on<ProductsGridPageSearchQueryChangedEvent>(_onSearchQueryChanged);
  }

  final MarketplaceRepository marketplaceRepository;

  Future<void> _onLoad(
    ProductsGridPageLoadEvent event,
    Emitter<ProductsGridPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final [
        categories as List<MarketplaceCategoryEntity>,
        items as List<MarketplaceItemEntity>,
      ] = await Future.wait([
        marketplaceRepository.getCategories(),
        marketplaceRepository.getItems(),
      ]);

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          categories: categories,
          items: items,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onCategorySelected(
    ProductsGridPageCategorySelectedEvent event,
    Emitter<ProductsGridPageState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        selectedCategoryId: () => event.categoryId,
      ),
    );
    try {
      final items = await marketplaceRepository.getItems(
        categoryId: event.categoryId,
        search: state.searchQuery,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded, items: items));
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onSearchQueryChanged(
    ProductsGridPageSearchQueryChangedEvent event,
    Emitter<ProductsGridPageState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        searchQuery: event.searchQuery,
      ),
    );
    try {
      final items = await marketplaceRepository.getItems(
        categoryId: state.selectedCategoryId,
        search: event.searchQuery,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded, items: items));
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
