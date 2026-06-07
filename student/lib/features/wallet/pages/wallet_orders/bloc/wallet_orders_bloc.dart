import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'wallet_orders_event.dart';
part 'wallet_orders_state.dart';

sealed class WalletOrdersPresentationEvent {
  const WalletOrdersPresentationEvent();
}

final class WalletOrdersBloc
    extends Bloc<WalletOrdersEvent, WalletOrdersState>
    with
        BlocPresentationMixin<
          WalletOrdersState,
          WalletOrdersPresentationEvent
        > {
  WalletOrdersBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(WalletOrdersState.initial) {
    on<WalletOrdersLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    WalletOrdersLoadEvent event,
    Emitter<WalletOrdersState> emit,
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
