import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'purchase_confirm_page_event.dart';
part 'purchase_confirm_page_state.dart';

sealed class PurchaseConfirmPagePresentationEvent {
  const PurchaseConfirmPagePresentationEvent();
}

final class PurchaseConfirmPageNavigateBack
    extends PurchaseConfirmPagePresentationEvent {
  const PurchaseConfirmPageNavigateBack();
}

final class PurchaseConfirmPageBloc
    extends Bloc<PurchaseConfirmPageEvent, PurchaseConfirmPageState>
    with
        BlocPresentationMixin<
          PurchaseConfirmPageState,
          PurchaseConfirmPagePresentationEvent
        > {
  PurchaseConfirmPageBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(PurchaseConfirmPageState.initial) {
    on<PurchaseConfirmPageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    PurchaseConfirmPageLoadEvent event,
    Emitter<PurchaseConfirmPageState> emit,
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
