import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'transactions_history_page_event.dart';
part 'transactions_history_page_state.dart';

sealed class TransactionsHistoryPagePresentationEvent {
  const TransactionsHistoryPagePresentationEvent();
}

final class TransactionsHistoryPageNavigateBack
    extends TransactionsHistoryPagePresentationEvent {
  const TransactionsHistoryPageNavigateBack();
}

final class TransactionsHistoryPageBloc
    extends Bloc<TransactionsHistoryPageEvent, TransactionsHistoryPageState>
    with
        BlocPresentationMixin<
          TransactionsHistoryPageState,
          TransactionsHistoryPagePresentationEvent
        > {
  TransactionsHistoryPageBloc({required this.walletRepository})
    : super(TransactionsHistoryPageState.initial) {
    on<TransactionsHistoryPageLoadEvent>(_onLoad);
    on<TransactionsHistoryPageLoadMoreEvent>(_onLoadMore);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    TransactionsHistoryPageLoadEvent event,
    Emitter<TransactionsHistoryPageState> emit,
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
    TransactionsHistoryPageLoadMoreEvent event,
    Emitter<TransactionsHistoryPageState> emit,
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
