import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import '../../../../../core/core.dart';

part 'marketplace_orders_page_event.dart';
part 'marketplace_orders_page_state.dart';

sealed class MarketplaceOrdersPagePresentationEvent {
  const MarketplaceOrdersPagePresentationEvent();
}

final class OrderHistoryFailurePresentationEvent
    extends MarketplaceOrdersPagePresentationEvent {
  final String message;

  const OrderHistoryFailurePresentationEvent({required this.message});
}

final class MarketplaceOrdersPageBloc
    extends Bloc<MarketplaceOrdersPageEvent, MarketplaceOrdersPageState>
    with
        BlocPresentationMixin<
          MarketplaceOrdersPageState,
          MarketplaceOrdersPagePresentationEvent
        > {
  final MarketplaceRepository _marketplaceRepository;

  MarketplaceOrdersPageBloc({required MarketplaceRepository marketplaceRepository})
    : _marketplaceRepository = marketplaceRepository,
      super(MarketplaceOrdersPageState.initial) {
    on<MarketplaceOrdersPageInitialized>(_onInitialized);
    on<MarketplaceOrdersPageRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    MarketplaceOrdersPageInitialized event,
    Emitter<MarketplaceOrdersPageState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _onRefreshed(
    MarketplaceOrdersPageRefreshed event,
    Emitter<MarketplaceOrdersPageState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _load(Emitter<MarketplaceOrdersPageState> emit) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      final orders = await _marketplaceRepository.getOrders();
      emit(state.copyWith(loadingState: LoadingState.loaded, orders: orders));
    } on MarketplaceRepositoryException catch (e) {
      final message = e.message ?? 'Unable to load orders.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(OrderHistoryFailurePresentationEvent(message: message));
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(OrderHistoryFailurePresentationEvent(message: message));
    }
  }
}
