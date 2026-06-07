import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'redeem_code_event.dart';
part 'redeem_code_state.dart';

sealed class RedeemCodePresentationEvent {
  const RedeemCodePresentationEvent();
}

final class RedeemCodeNavigateBack extends RedeemCodePresentationEvent {
  const RedeemCodeNavigateBack();
}

final class RedeemCodeBloc
    extends Bloc<RedeemCodeEvent, RedeemCodeState>
    with
        BlocPresentationMixin<
          RedeemCodeState,
          RedeemCodePresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('RedeemCodeBloc');

  RedeemCodeBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(RedeemCodeState.initial) {
    on<RedeemCodeLoadEvent>(_onLoad);
    on<RedeemCodeSubmitEvent>(_onSubmit);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    RedeemCodeLoadEvent event,
    Emitter<RedeemCodeState> emit,
  ) async {
    _logger.info('Handling RedeemCodeLoadEvent');
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    RedeemCodeSubmitEvent event,
    Emitter<RedeemCodeState> emit,
  ) async {
    _logger.info('Handling RedeemCodeSubmitEvent: code=${event.code}');
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await walletRepository.redeemCode(event.code);
      emit(state.copyWith(loadingState: LoadingState.loaded));
      analyticsService.logEvent(
        name: 'wallet_redeem_success',
        parameters: {'code': event.code},
      );
      emitPresentation(const RedeemCodeNavigateBack());
      _logger.info('Code successfully redeemed: ${event.code}');
    } catch (e, s) {
      _logger.error('Failed to redeem code: ${event.code}', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
