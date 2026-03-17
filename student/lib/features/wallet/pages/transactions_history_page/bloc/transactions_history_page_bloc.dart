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
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    TransactionsHistoryPageLoadEvent event,
    Emitter<TransactionsHistoryPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
