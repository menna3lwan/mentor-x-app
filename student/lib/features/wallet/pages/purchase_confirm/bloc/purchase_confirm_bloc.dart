import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'purchase_confirm_event.dart';
part 'purchase_confirm_state.dart';

sealed class PurchaseConfirmPresentationEvent {
  const PurchaseConfirmPresentationEvent();
}

final class PurchaseConfirmNavigateBack
    extends PurchaseConfirmPresentationEvent {
  const PurchaseConfirmNavigateBack();
}

final class PurchaseConfirmBloc
    extends Bloc<PurchaseConfirmEvent, PurchaseConfirmState>
    with
        BlocPresentationMixin<
          PurchaseConfirmState,
          PurchaseConfirmPresentationEvent
        > {
  PurchaseConfirmBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(PurchaseConfirmState.initial) {
    on<PurchaseConfirmLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    PurchaseConfirmLoadEvent event,
    Emitter<PurchaseConfirmState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: null,
        paymentId: event.paymentId,
      ),
    );
    try {
      final payment = await walletRepository.getPaymentStatus(event.paymentId);
      analyticsService.logEvent(
        name: AnalyticsEvents.purchaseConfirmViewed,
        parameters: {AnalyticsParams.id: event.paymentId},
      );
      emit(state.copyWith(loadingState: LoadingState.loaded, payment: payment));
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
