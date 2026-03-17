import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'payment_success_page_event.dart';
part 'payment_success_page_state.dart';

sealed class PaymentSuccessPagePresentationEvent {
  const PaymentSuccessPagePresentationEvent();
}

final class PaymentSuccessPageNavigateBack
    extends PaymentSuccessPagePresentationEvent {
  const PaymentSuccessPageNavigateBack();
}

final class PaymentSuccessPageBloc
    extends Bloc<PaymentSuccessPageEvent, PaymentSuccessPageState>
    with
        BlocPresentationMixin<
          PaymentSuccessPageState,
          PaymentSuccessPagePresentationEvent
        > {
  PaymentSuccessPageBloc() : super(PaymentSuccessPageState.initial) {
    on<PaymentSuccessPageLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    PaymentSuccessPageLoadEvent event,
    Emitter<PaymentSuccessPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
