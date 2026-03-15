import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'redeem_code_page_event.dart';
part 'redeem_code_page_state.dart';

sealed class RedeemCodePagePresentationEvent {
  const RedeemCodePagePresentationEvent();
}

final class RedeemCodePageNavigateBack extends RedeemCodePagePresentationEvent {
  const RedeemCodePageNavigateBack();
}

final class RedeemCodePageBloc
    extends Bloc<RedeemCodePageEvent, RedeemCodePageState>
    with
        BlocPresentationMixin<
          RedeemCodePageState,
          RedeemCodePagePresentationEvent
        > {
  RedeemCodePageBloc({required this.walletRepository})
    : super(RedeemCodePageState.initial) {
    on<RedeemCodePageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    RedeemCodePageLoadEvent event,
    Emitter<RedeemCodePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
