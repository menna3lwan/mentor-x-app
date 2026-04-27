import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'add_balance_page_event.dart';
part 'add_balance_page_state.dart';

sealed class AddBalancePagePresentationEvent {
  const AddBalancePagePresentationEvent();
}

final class AddBalancePageSuccess extends AddBalancePagePresentationEvent {
  final PaymentEntity payment;
  const AddBalancePageSuccess(this.payment);
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
    on<AddBalancePageSubmitEvent>(_onSubmit);
  }

  final WalletRepository walletRepository;

  Future<void> _onLoad(
    AddBalancePageLoadEvent event,
    Emitter<AddBalancePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading, errorMessage: null));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    AddBalancePageSubmitEvent event,
    Emitter<AddBalancePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading, errorMessage: null));
    try {
      final payment = await walletRepository.initiatePayment(
        amount: event.amount,
        method: event.method,
        paymentType: PaymentType.walletTopup,
      );
      
      emit(state.copyWith(
        loadingState: LoadingState.loaded,
        payment: payment,
      ));
      
      emitPresentation(AddBalancePageSuccess(payment));
    } catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
