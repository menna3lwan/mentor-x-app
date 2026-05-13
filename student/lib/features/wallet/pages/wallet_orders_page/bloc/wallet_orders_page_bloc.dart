import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'wallet_orders_page_event.dart';
part 'wallet_orders_page_state.dart';

sealed class WalletOrdersPagePresentationEvent {
  const WalletOrdersPagePresentationEvent();
}

final class WalletOrdersPageBloc
    extends Bloc<WalletOrdersPageEvent, WalletOrdersPageState>
    with
        BlocPresentationMixin<
          WalletOrdersPageState,
          WalletOrdersPagePresentationEvent
        > {
  WalletOrdersPageBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(WalletOrdersPageState.initial) {
    on<WalletOrdersPageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    WalletOrdersPageLoadEvent event,
    Emitter<WalletOrdersPageState> emit,
  ) async {
    analyticsService.logEvent(name: AnalyticsEvents.walletOrdersViewed);
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      final orders = await walletRepository.getOrders();
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          orders: orders,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
