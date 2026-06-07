import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'wallet_main_event.dart';
part 'wallet_main_state.dart';

sealed class WalletMainPresentationEvent {
  const WalletMainPresentationEvent();
}

final class WalletMainNavigateBack extends WalletMainPresentationEvent {
  const WalletMainNavigateBack();
}

final class WalletMainBloc
    extends Bloc<WalletMainEvent, WalletMainState>
    with
        BlocPresentationMixin<
          WalletMainState,
          WalletMainPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('WalletMainBloc');

  WalletMainBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(WalletMainState.initial) {
    on<WalletMainLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    WalletMainLoadEvent event,
    Emitter<WalletMainState> emit,
  ) async {
    _logger.info('Handling WalletMainLoadEvent');
    analyticsService.logEvent(name: AnalyticsEvents.transactionHistoryViewed);
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
      ),
    );

    try {
      final summary = await walletRepository.getSummary();
      final transactions = await walletRepository.getTransactions(
        paginationInfo: const MentorXPaginationInfo(page: 0, limit: 5),
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          summary: MentorXNullableValue(summary),
          transactions: transactions,
        ),
      );
      _logger.info('Wallet main summary and recent transactions loaded successfully');
    } on MentorXException catch (e, s) {
      _logger.error('Failed to load wallet main details (MentorXException)', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e, s) {
      _logger.error('Failed to load wallet main details', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }
}
