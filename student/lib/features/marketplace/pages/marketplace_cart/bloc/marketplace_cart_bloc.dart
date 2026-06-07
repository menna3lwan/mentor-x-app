import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'marketplace_cart_event.dart';
part 'marketplace_cart_state.dart';

sealed class MarketplaceCartPresentationEvent {
  const MarketplaceCartPresentationEvent();
}

final class MarketplaceCartNavigateBack
    extends MarketplaceCartPresentationEvent {
  const MarketplaceCartNavigateBack();
}

final class MarketplaceCartOrderPlacedSuccess
    extends MarketplaceCartPresentationEvent {
  const MarketplaceCartOrderPlacedSuccess();
}

final class MarketplaceCartOrderPlacedError
    extends MarketplaceCartPresentationEvent {
  const MarketplaceCartOrderPlacedError();
}

final class MarketplaceCartBloc
    extends Bloc<MarketplaceCartEvent, MarketplaceCartState>
    with
        BlocPresentationMixin<
          MarketplaceCartState,
          MarketplaceCartPresentationEvent
        > {
  MarketplaceCartBloc({
    required this.marketplaceRepository,
    required this.walletRepository,
    required this.analyticsService,
  }) : super(MarketplaceCartState.initial) {
    on<MarketplaceCartLoadEvent>(_onLoad);
    on<MarketplaceCartPlaceOrderEvent>(_onPlaceOrder);
  }

  final MarketplaceRepository marketplaceRepository;
  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    MarketplaceCartLoadEvent event,
    Emitter<MarketplaceCartState> emit,
  ) async {
    analyticsService.logEvent(name: AnalyticsEvents.cartViewed);
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final [walletSummary, validCoupons] = await Future.wait([
        walletRepository.getSummary(),
        walletRepository.getValidCoupons(),
      ]);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          walletSummary: walletSummary as WalletSummaryEntity,
          validCoupons: validCoupons as List<CouponEntity>,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }

  Future<void> _onPlaceOrder(
    MarketplaceCartPlaceOrderEvent event,
    Emitter<MarketplaceCartState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await marketplaceRepository.placeOrder(
        items: event.items,
        deliveryAddress: event.address,
        deliveryPhone: event.phone,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(const MarketplaceCartOrderPlacedSuccess());
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
      emitPresentation(const MarketplaceCartOrderPlacedError());
    }
  }
}
