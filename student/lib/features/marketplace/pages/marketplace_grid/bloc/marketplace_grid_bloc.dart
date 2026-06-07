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
  static final MentorXLogger _logger = MentorXLogger('MarketplaceGridBloc');

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
    _logger.info('Handling MarketplaceGridLoadEvent');
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
      _logger.info('Marketplace grid loaded successfully');
    } catch (e, s) {
      _logger.error('Failed to load marketplace grid data', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onCategorySelected(
    MarketplaceGridCategorySelectedEvent event,
    Emitter<MarketplaceGridState> emit,
  ) async {
    _logger.info('Handling MarketplaceGridCategorySelectedEvent: id=${event.categoryId}');
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
      _logger.info('Category selected and items loaded successfully');
    } catch (e, s) {
      _logger.error('Failed to load items for category: ${event.categoryId}', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onSearchQueryChanged(
    MarketplaceGridSearchQueryChangedEvent event,
    Emitter<MarketplaceGridState> emit,
  ) async {
    _logger.info('Handling MarketplaceGridSearchQueryChangedEvent: query=${event.searchQuery}');
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
      _logger.info('Search query processed and items loaded successfully');
    } catch (e, s) {
      _logger.error('Failed to search marketplace items for: ${event.searchQuery}', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
