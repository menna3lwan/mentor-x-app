import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
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

final class ShoppingCartPageBloc
    extends Bloc<ShoppingCartPageEvent, ShoppingCartPageState>
    with
        BlocPresentationMixin<
          ShoppingCartPageState,
          ShoppingCartPagePresentationEvent
        > {
  ShoppingCartPageBloc({required this.marketplaceRepository})
    : super(ShoppingCartPageState.initial) {
    on<ShoppingCartPageLoadEvent>(_onLoad);
  }

  final MarketplaceRepository marketplaceRepository;

  Future<void> _onLoad(
    ShoppingCartPageLoadEvent event,
    Emitter<ShoppingCartPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
