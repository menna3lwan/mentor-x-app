import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'marketplace_cart_page_event.dart';
part 'marketplace_cart_page_state.dart';

sealed class MarketplaceCartPagePresentationEvent {
  const MarketplaceCartPagePresentationEvent();
}

final class MarketplaceCartPageNavigateBack
    extends MarketplaceCartPagePresentationEvent {
  const MarketplaceCartPageNavigateBack();
}

final class MarketplaceCartPageOrderPlacedSuccess
    extends MarketplaceCartPagePresentationEvent {
  const MarketplaceCartPageOrderPlacedSuccess();
}

final class MarketplaceCartPageOrderPlacedError
    extends MarketplaceCartPagePresentationEvent {
  const MarketplaceCartPageOrderPlacedError();
}

final class MarketplaceCartPageBloc
    extends Bloc<MarketplaceCartPageEvent, MarketplaceCartPageState>
    with
        BlocPresentationMixin<
          MarketplaceCartPageState,
          MarketplaceCartPagePresentationEvent
        > {
  MarketplaceCartPageBloc({
    required this.marketplaceRepository,
    required this.walletRepository,
  }) : super(MarketplaceCartPageState.initial) {
    on<MarketplaceCartPageLoadEvent>(_onLoad);
    on<MarketplaceCartPagePlaceOrderEvent>(_onPlaceOrder);
  }

  final MarketplaceRepository marketplaceRepository;
  final WalletRepository walletRepository;

  Future<void> _onLoad(
    MarketplaceCartPageLoadEvent event,
    Emitter<MarketplaceCartPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final walletSummary = await walletRepository.getSummary();
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          walletSummary: walletSummary,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onPlaceOrder(
    MarketplaceCartPagePlaceOrderEvent event,
    Emitter<MarketplaceCartPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await marketplaceRepository.placeOrder(
        items: event.items,
        deliveryAddress: event.address,
        deliveryPhone: event.phone,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(const MarketplaceCartPageOrderPlacedSuccess());
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
      emitPresentation(const MarketplaceCartPageOrderPlacedError());
    }
  }
}
