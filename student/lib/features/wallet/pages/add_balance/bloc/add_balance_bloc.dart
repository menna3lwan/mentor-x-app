import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'add_balance_event.dart';
part 'add_balance_state.dart';

sealed class AddBalancePresentationEvent {
  const AddBalancePresentationEvent();
}

final class AddBalanceSuccess extends AddBalancePresentationEvent {
  final double amount;
  const AddBalanceSuccess(this.amount);
}

final class AddBalanceBloc
    extends Bloc<AddBalanceEvent, AddBalanceState>
    with
        BlocPresentationMixin<
          AddBalanceState,
          AddBalancePresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('AddBalanceBloc');

  AddBalanceBloc({
    required this.walletRepository,
    required this.analyticsService,
  }) : super(AddBalanceState.initial) {
    on<AddBalanceLoadEvent>(_onLoad);
    on<AddBalanceSubmitEvent>(_onSubmit);
  }

  final WalletRepository walletRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AddBalanceLoadEvent event,
    Emitter<AddBalanceState> emit,
  ) async {
    _logger.info('Handling AddBalanceLoadEvent');
    analyticsService.logEvent(name: AnalyticsEvents.addBalanceStarted);
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    AddBalanceSubmitEvent event,
    Emitter<AddBalanceState> emit,
  ) async {
    _logger.info('Handling AddBalanceSubmitEvent: amount=${event.amount}, method=${event.method}');
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

      emitPresentation(AddBalanceSuccess(event.amount));
      _logger.info('Deposit funds submitted successfully');
    } catch (e, s) {
      _logger.error('Failed to deposit funds', e, s);
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
