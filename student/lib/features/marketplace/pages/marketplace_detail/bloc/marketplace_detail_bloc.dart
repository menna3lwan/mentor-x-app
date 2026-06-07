import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'marketplace_detail_event.dart';
part 'marketplace_detail_state.dart';

sealed class MarketplaceDetailPresentationEvent {
  const MarketplaceDetailPresentationEvent();
}

final class MarketplaceDetailNavigateBack
    extends MarketplaceDetailPresentationEvent {
  const MarketplaceDetailNavigateBack();
}

final class MarketplaceDetailBloc
    extends Bloc<MarketplaceDetailEvent, MarketplaceDetailState>
    with
        BlocPresentationMixin<
          MarketplaceDetailState,
          MarketplaceDetailPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('MarketplaceDetailBloc');

  MarketplaceDetailBloc({
    required this.marketplaceRepository,
    required this.analyticsService,
  }) : super(MarketplaceDetailState.initial) {
    on<MarketplaceDetailLoadEvent>(_onLoad);
  }

  final MarketplaceRepository marketplaceRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    MarketplaceDetailLoadEvent event,
    Emitter<MarketplaceDetailState> emit,
  ) async {
    _logger.info('Handling MarketplaceDetailLoadEvent for itemId: ${event.itemId}');
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final items = await marketplaceRepository.getItems();
      final item = items.firstWhere((i) => i.id == event.itemId);
      analyticsService.logEvent(
        name: AnalyticsEvents.itemViewed,
        parameters: {
          AnalyticsParams.itemId: item.id,
          AnalyticsParams.itemName: item.title,
        },
      );
      emit(state.copyWith(loadingState: LoadingState.loaded, item: item));
      _logger.info('Item details loaded successfully for itemId: ${event.itemId}');
    } catch (e, s) {
      _logger.error('Failed to load item details for itemId: ${event.itemId}', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
