import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'shopping_cart_page_event.dart';
part 'shopping_cart_page_state.dart';

sealed class ShoppingCartPagePresentationEvent {
  const ShoppingCartPagePresentationEvent();
}

final class ShoppingCartPageNavigateBack
    extends ShoppingCartPagePresentationEvent {
  const ShoppingCartPageNavigateBack();
}

final class ShoppingCartPageOrderPlacedSuccess
    extends ShoppingCartPagePresentationEvent {
  const ShoppingCartPageOrderPlacedSuccess();
}

final class ShoppingCartPageOrderPlacedError
    extends ShoppingCartPagePresentationEvent {
  const ShoppingCartPageOrderPlacedError();
}

final class ShoppingCartPageBloc
    extends Bloc<ShoppingCartPageEvent, ShoppingCartPageState>
    with
        BlocPresentationMixin<
          ShoppingCartPageState,
          ShoppingCartPagePresentationEvent
        > {
  ShoppingCartPageBloc({
    required this.marketplaceRepository,
    required this.walletRepository,
  }) : super(ShoppingCartPageState.initial) {
    on<ShoppingCartPageLoadEvent>(_onLoad);
    on<ShoppingCartPagePlaceOrderEvent>(_onPlaceOrder);
  }

  final MarketplaceRepository marketplaceRepository;
  final WalletRepository walletRepository;

  Future<void> _onLoad(
    ShoppingCartPageLoadEvent event,
    Emitter<ShoppingCartPageState> emit,
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
    ShoppingCartPagePlaceOrderEvent event,
    Emitter<ShoppingCartPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await marketplaceRepository.placeOrder(
        items: event.items,
        deliveryAddress: event.address,
        deliveryPhone: event.phone,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(const ShoppingCartPageOrderPlacedSuccess());
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
      emitPresentation(const ShoppingCartPageOrderPlacedError());
    }
  }
}
