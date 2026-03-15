import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'add_balance_page_event.dart';
part 'add_balance_page_state.dart';

sealed class AddBalancePagePresentationEvent {
  const AddBalancePagePresentationEvent();
}

final class AddBalancePageNavigateBack extends AddBalancePagePresentationEvent {
  const AddBalancePageNavigateBack();
}

final class AddBalancePageBloc
    extends Bloc<AddBalancePageEvent, AddBalancePageState>
    with
        BlocPresentationMixin<
          AddBalancePageState,
          AddBalancePagePresentationEvent
        > {
  AddBalancePageBloc({required this.walletRepository})
    : super(AddBalancePageState.initial) {
    on<AddBalancePageLoadEvent>(_onLoad);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    AddBalancePageLoadEvent event,
    Emitter<AddBalancePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
