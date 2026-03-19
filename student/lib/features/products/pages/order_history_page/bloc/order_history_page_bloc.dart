import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import '../../../../../core/core.dart';

part 'order_history_page_event.dart';
part 'order_history_page_state.dart';

sealed class OrderHistoryPagePresentationEvent {
  const OrderHistoryPagePresentationEvent();
}

final class OrderHistoryFailurePresentationEvent
    extends OrderHistoryPagePresentationEvent {
  final String message;

  const OrderHistoryFailurePresentationEvent({required this.message});
}

final class OrderHistoryPageBloc
    extends Bloc<OrderHistoryPageEvent, OrderHistoryPageState>
    with
        BlocPresentationMixin<
          OrderHistoryPageState,
          OrderHistoryPagePresentationEvent
        > {
  final MarketplaceRepository _marketplaceRepository;

  OrderHistoryPageBloc({required MarketplaceRepository marketplaceRepository})
    : _marketplaceRepository = marketplaceRepository,
      super(OrderHistoryPageState.initial) {
    on<OrderHistoryPageInitialized>(_onInitialized);
    on<OrderHistoryPageRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    OrderHistoryPageInitialized event,
    Emitter<OrderHistoryPageState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _onRefreshed(
    OrderHistoryPageRefreshed event,
    Emitter<OrderHistoryPageState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _load(Emitter<OrderHistoryPageState> emit) async {
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
