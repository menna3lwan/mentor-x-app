import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'wallet_main_page_event.dart';
part 'wallet_main_page_state.dart';

sealed class WalletMainPagePresentationEvent {
  const WalletMainPagePresentationEvent();
}

final class WalletMainPageNavigateBack extends WalletMainPagePresentationEvent {
  const WalletMainPageNavigateBack();
}

final class WalletMainPageBloc
    extends Bloc<WalletMainPageEvent, WalletMainPageState>
    with
        BlocPresentationMixin<
          WalletMainPageState,
          WalletMainPagePresentationEvent
        > {
  WalletMainPageBloc({required this.walletRepository})
    : super(WalletMainPageState.initial) {
    on<WalletMainPageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    WalletMainPageLoadEvent event,
    Emitter<WalletMainPageState> emit,
  ) async {
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
}
