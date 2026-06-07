import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'transactions_history_event.dart';
part 'transactions_history_state.dart';

sealed class TransactionsHistoryPresentationEvent {
  const TransactionsHistoryPresentationEvent();
}

final class TransactionsHistoryNavigateBack
    extends TransactionsHistoryPresentationEvent {
  const TransactionsHistoryNavigateBack();
}

final class TransactionsHistoryBloc
    extends Bloc<TransactionsHistoryEvent, TransactionsHistoryState>
    with
        BlocPresentationMixin<
          TransactionsHistoryState,
          TransactionsHistoryPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('TransactionsHistoryBloc');

  TransactionsHistoryBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(TransactionsHistoryState.initial) {
    on<TransactionsHistoryLoadEvent>(_onLoad);
    on<TransactionsHistoryLoadMoreEvent>(_onLoadMore);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    TransactionsHistoryLoadEvent event,
    Emitter<TransactionsHistoryState> emit,
  ) async {
    _logger.info('Handling TransactionsHistoryLoadEvent');
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
        transactions: [],
        currentPage: 0,
        hasMore: true,
      ),
    );

    try {
      final transactions = await walletRepository.getTransactions(
        paginationInfo: const MentorXPaginationInfo(page: 0, limit: 20),
      );

      analyticsService.logEvent(name: AnalyticsEvents.transactionHistoryViewed);

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          transactions: transactions,
          hasMore: transactions.length >= 20,
          currentPage: 0,
        ),
      );
      _logger.info('Transactions history loaded successfully: count=${transactions.length}');
    } on MentorXException catch (e, s) {
      _logger.error('Failed to load transactions history (MentorXException)', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e, s) {
      _logger.error('Failed to load transactions history', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    TransactionsHistoryLoadMoreEvent event,
    Emitter<TransactionsHistoryState> emit,
  ) async {
    _logger.info('Handling TransactionsHistoryLoadMoreEvent: currentPage=${state.currentPage}');
    if (!state.hasMore || state.loadingState == LoadingState.loading) return;

    final nextPage = state.currentPage + 1;

    try {
      final moreTransactions = await walletRepository.getTransactions(
        paginationInfo: MentorXPaginationInfo(page: nextPage, limit: 20),
      );

      emit(
        state.copyWith(
          transactions: [...state.transactions, ...moreTransactions],
          hasMore: moreTransactions.length >= 20,
          currentPage: nextPage,
        ),
      );
      _logger.info('Loaded more transactions successfully: count=${moreTransactions.length}');
    } catch (e, s) {
      _logger.error('Failed to load more transactions', e, s);
      // Ignore pagination errors for now
    }
  }
}
