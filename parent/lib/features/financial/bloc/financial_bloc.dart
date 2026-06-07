import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'financial_event.dart';
part 'financial_state.dart';

final class FinancialBloc extends Bloc<FinancialEvent, FinancialState> {
  final ParentFinancialRepository _repository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('FinancialBloc');

  FinancialBloc({
    required ParentFinancialRepository repository,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _analyticsService = analyticsService,
        super(const FinancialState()) {
    on<FinancialStarted>(_onStarted);
    on<FinancialRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
      FinancialStarted event, Emitter<FinancialState> emit) async {
    final childId = event.childId;
    _logger.info('Started loading financial for childId: $childId');
    if (childId == null) {
      _logger.error('Failed to load financial: Child ID is required');
      emit(state.copyWith(
          status: FinancialStatus.failure, errorMessage: 'Child ID is required'));
      return;
    }

    emit(state.copyWith(status: FinancialStatus.loading));
    try {
      unawaited(_analyticsService.logEvent(name: AnalyticsEvents.walletViewed));
      
      final results = await Future.wait([
        _repository.getTransactions(childId),
        _repository.getPayments(childId),
        _repository.getWalletSummary(childId),
        _repository.getWalletAnalytics(childId),
      ]);

      _logger.info('Successfully loaded financial data for childId: $childId');
      emit(state.copyWith(
        status: FinancialStatus.success,
        transactions: results[0] as List<WalletTransactionEntity>,
        paymentMethods: results[1] as List<PaymentEntity>,
        walletSummary: results[2] as WalletSummaryEntity,
        analytics: results[3] as ParentWalletAnalyticsEntity,
      ));
    } catch (e, s) {
      _logger.error('Failed to load financial data for childId: $childId', e, s);
      emit(state.copyWith(
        status: FinancialStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
      FinancialRefreshRequested event, Emitter<FinancialState> emit) async {
    _logger.info('Refresh requested for childId: ${event.childId}');
    add(FinancialStarted(childId: event.childId));
  }
}
