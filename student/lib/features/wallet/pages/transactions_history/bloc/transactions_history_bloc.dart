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
    } on MentorXException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e) {
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
    } catch (e) {
      // Ignore pagination errors for now
    }
  }
}
