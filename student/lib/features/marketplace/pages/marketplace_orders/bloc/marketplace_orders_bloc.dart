import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'marketplace_orders_event.dart';
part 'marketplace_orders_state.dart';

sealed class MarketplaceOrdersPresentationEvent {
  const MarketplaceOrdersPresentationEvent();
}

final class OrderHistoryFailurePresentationEvent
    extends MarketplaceOrdersPresentationEvent {
  final String message;

  const OrderHistoryFailurePresentationEvent({required this.message});
}

final class MarketplaceOrdersBloc
    extends Bloc<MarketplaceOrdersEvent, MarketplaceOrdersState>
    with
        BlocPresentationMixin<
          MarketplaceOrdersState,
          MarketplaceOrdersPresentationEvent
        > {
  final MarketplaceRepository _marketplaceRepository;
  final AnalyticsService _analyticsService;

  MarketplaceOrdersBloc({
    required MarketplaceRepository marketplaceRepository,
    required AnalyticsService analyticsService,
  }) : _marketplaceRepository = marketplaceRepository,
       _analyticsService = analyticsService,
       super(MarketplaceOrdersState.initial) {
    on<MarketplaceOrdersInitialized>(_onInitialized);
    on<MarketplaceOrdersRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    MarketplaceOrdersInitialized event,
    Emitter<MarketplaceOrdersState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.ordersViewed);
    await _load(emit);
  }

  Future<void> _onRefreshed(
    MarketplaceOrdersRefreshed event,
    Emitter<MarketplaceOrdersState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _load(Emitter<MarketplaceOrdersState> emit) async {
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
