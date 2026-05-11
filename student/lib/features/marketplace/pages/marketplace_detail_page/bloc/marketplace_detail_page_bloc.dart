import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'marketplace_detail_page_event.dart';
part 'marketplace_detail_page_state.dart';

sealed class MarketplaceDetailPagePresentationEvent {
  const MarketplaceDetailPagePresentationEvent();
}

final class MarketplaceDetailPageNavigateBack
    extends MarketplaceDetailPagePresentationEvent {
  const MarketplaceDetailPageNavigateBack();
}

final class MarketplaceDetailPageBloc
    extends Bloc<MarketplaceDetailPageEvent, MarketplaceDetailPageState>
    with
        BlocPresentationMixin<
          MarketplaceDetailPageState,
          MarketplaceDetailPagePresentationEvent
        > {
  MarketplaceDetailPageBloc({required this.marketplaceRepository})
    : super(MarketplaceDetailPageState.initial) {
    on<MarketplaceDetailPageLoadEvent>(_onLoad);
  }

  final MarketplaceRepository marketplaceRepository;

  Future<void> _onLoad(
    MarketplaceDetailPageLoadEvent event,
    Emitter<MarketplaceDetailPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final items = await marketplaceRepository.getItems();
      final item = items.firstWhere((i) => i.id == event.itemId);
      emit(state.copyWith(loadingState: LoadingState.loaded, item: item));
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
