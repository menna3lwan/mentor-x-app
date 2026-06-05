import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'add_balance_page_event.dart';
part 'add_balance_page_state.dart';

sealed class AddBalancePagePresentationEvent {
  const AddBalancePagePresentationEvent();
}

final class AddBalancePageSuccess extends AddBalancePagePresentationEvent {
  final double amount;
  const AddBalancePageSuccess(this.amount);
}

final class AddBalancePageBloc
    extends Bloc<AddBalancePageEvent, AddBalancePageState>
    with
        BlocPresentationMixin<
          AddBalancePageState,
          AddBalancePagePresentationEvent
        > {
  AddBalancePageBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(AddBalancePageState.initial) {
    on<AddBalancePageLoadEvent>(_onLoad);
    on<AddBalancePageSubmitEvent>(_onSubmit);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AddBalancePageLoadEvent event,
    Emitter<AddBalancePageState> emit,
  ) async {
    analyticsService.logEvent(name: AnalyticsEvents.addBalanceStarted);
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    AddBalancePageSubmitEvent event,
    Emitter<AddBalancePageState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      await walletRepository.depositFunds(
        amount: event.amount,
        method: event.method,
      );

      analyticsService.logEvent(
        name: AnalyticsEvents.addBalanceCompleted,
        parameters: {
          AnalyticsParams.amount: event.amount,
          AnalyticsParams.paymentMethod: event.method.name,
        },
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
        ),
      );

      emitPresentation(AddBalancePageSuccess(event.amount));
    } catch (e) {
      analyticsService.logEvent(
        name: AnalyticsEvents.addBalanceFailed,
        parameters: {
          AnalyticsParams.amount: event.amount,
          AnalyticsParams.paymentMethod: event.method.name,
          AnalyticsParams.errorMessage: e.toString(),
        },
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
