import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:analytics_service/analytics_service.dart';

part 'marketplace_grid_page_event.dart';
part 'marketplace_grid_page_state.dart';

sealed class MarketplaceGridPagePresentationEvent {
  const MarketplaceGridPagePresentationEvent();
}

final class MarketplaceGridPageNavigateBack
    extends MarketplaceGridPagePresentationEvent {
  const MarketplaceGridPageNavigateBack();
}

final class MarketplaceGridPageBloc
    extends Bloc<MarketplaceGridPageEvent, MarketplaceGridPageState>
    with
        BlocPresentationMixin<
          MarketplaceGridPageState,
          MarketplaceGridPagePresentationEvent
        > {
  MarketplaceGridPageBloc({
    required this.marketplaceRepository,
    required this.analyticsService,
  }) : super(MarketplaceGridPageState.initial) {
    on<MarketplaceGridPageLoadEvent>(_onLoad);
    on<MarketplaceGridPageCategorySelectedEvent>(_onCategorySelected);
    on<MarketplaceGridPageSearchQueryChangedEvent>(_onSearchQueryChanged);
  }

  final MarketplaceRepository marketplaceRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    MarketplaceGridPageLoadEvent event,
    Emitter<MarketplaceGridPageState> emit,
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
    MarketplaceGridPageCategorySelectedEvent event,
    Emitter<MarketplaceGridPageState> emit,
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
    MarketplaceGridPageSearchQueryChangedEvent event,
    Emitter<MarketplaceGridPageState> emit,
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
