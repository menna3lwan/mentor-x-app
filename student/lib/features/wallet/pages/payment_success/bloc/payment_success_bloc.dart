import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'payment_success_event.dart';
part 'payment_success_state.dart';

sealed class PaymentSuccessPresentationEvent {
  const PaymentSuccessPresentationEvent();
}

final class PaymentSuccessNavigateBack
    extends PaymentSuccessPresentationEvent {
  const PaymentSuccessNavigateBack();
}

final class PaymentSuccessBloc
    extends Bloc<PaymentSuccessEvent, PaymentSuccessState>
    with
        BlocPresentationMixin<
          PaymentSuccessState,
          PaymentSuccessPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('PaymentSuccessBloc');

  PaymentSuccessBloc({required this.analyticsService})
    : super(PaymentSuccessState.initial) {
    on<PaymentSuccessLoadEvent>(_onLoad);
  }

  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    PaymentSuccessLoadEvent event,
    Emitter<PaymentSuccessState> emit,
  ) async {
    _logger.info('Handling PaymentSuccessLoadEvent');
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.paymentSuccessViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
