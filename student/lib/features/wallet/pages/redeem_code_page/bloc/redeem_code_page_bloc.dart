import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
  RedeemCodePageBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(RedeemCodePageState.initial) {
    on<RedeemCodePageLoadEvent>(_onLoad);
    on<RedeemCodePageSubmitEvent>(_onSubmit);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    RedeemCodePageLoadEvent event,
    Emitter<RedeemCodePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    RedeemCodePageSubmitEvent event,
    Emitter<RedeemCodePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await walletRepository.redeemCode(event.code);
      emit(state.copyWith(loadingState: LoadingState.loaded));
      analyticsService.logEvent(
        name: 'wallet_redeem_success',
        parameters: {'code': event.code},
      );
      emitPresentation(const RedeemCodePageNavigateBack());
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
