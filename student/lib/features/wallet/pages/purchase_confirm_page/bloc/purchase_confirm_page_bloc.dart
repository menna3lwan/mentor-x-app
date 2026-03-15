import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
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
  PurchaseConfirmPageBloc({required this.walletRepository})
    : super(PurchaseConfirmPageState.initial) {
    on<PurchaseConfirmPageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    PurchaseConfirmPageLoadEvent event,
    Emitter<PurchaseConfirmPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
