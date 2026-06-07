import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'marketplace_grid_event.dart';
part 'marketplace_grid_state.dart';

sealed class MarketplaceGridPresentationEvent {
  const MarketplaceGridPresentationEvent();
}

final class MarketplaceGridNavigateBack
    extends MarketplaceGridPresentationEvent {
  const MarketplaceGridNavigateBack();
}

final class MarketplaceGridBloc
    extends Bloc<MarketplaceGridEvent, MarketplaceGridState>
    with
        BlocPresentationMixin<
          MarketplaceGridState,
          MarketplaceGridPresentationEvent
        > {
  MarketplaceGridBloc({
    required this.marketplaceRepository,
    required this.analyticsService,
  }) : super(MarketplaceGridState.initial) {
    on<MarketplaceGridLoadEvent>(_onLoad);
    on<MarketplaceGridCategorySelectedEvent>(_onCategorySelected);
    on<MarketplaceGridSearchQueryChangedEvent>(_onSearchQueryChanged);
  }

  final MarketplaceRepository marketplaceRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    MarketplaceGridLoadEvent event,
    Emitter<MarketplaceGridState> emit,
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
    MarketplaceGridCategorySelectedEvent event,
    Emitter<MarketplaceGridState> emit,
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
      analyticsService.logEvent(
        name: AnalyticsEvents.marketplaceCategoryViewed,
        parameters: {AnalyticsParams.categoryId: event.categoryId},
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onSearchQueryChanged(
    MarketplaceGridSearchQueryChangedEvent event,
    Emitter<MarketplaceGridState> emit,
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
      analyticsService.logEvent(
        name: AnalyticsEvents.marketplaceSearched,
        parameters: {AnalyticsParams.query: event.searchQuery},
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
