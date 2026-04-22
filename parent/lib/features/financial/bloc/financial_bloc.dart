import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'financial_event.dart';
part 'financial_state.dart';

class FinancialBloc extends Bloc<FinancialEvent, FinancialState> {
  final ParentFinancialRepository _repository;

  FinancialBloc({
    required ParentFinancialRepository repository,
  })  : _repository = repository,
        super(const FinancialState()) {
    on<FinancialStarted>(_onStarted);
    on<FinancialRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
      FinancialStarted event, Emitter<FinancialState> emit) async {
    final childId = event.childId;
    if (childId == null) {
      emit(state.copyWith(
          status: FinancialStatus.failure, errorMessage: 'Child ID is required'));
      return;
    }

    emit(state.copyWith(status: FinancialStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getTransactions(childId),
        _repository.getPayments(childId),
        _repository.getWalletSummary(childId),
        _repository.getWalletAnalytics(childId),
      ]);

      emit(state.copyWith(
        status: FinancialStatus.success,
        transactions: results[0] as List<WalletTransactionEntity>,
        paymentMethods: results[1] as List<PaymentEntity>,
        walletSummary: results[2] as WalletSummaryEntity,
        analytics: results[3] as ParentWalletAnalyticsEntity,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
      FinancialRefreshRequested event, Emitter<FinancialState> emit) async {
    add(FinancialStarted(childId: event.childId));
  }
}
