import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'financial_event.dart';
part 'financial_state.dart';

final class FinancialBloc extends Bloc<FinancialEvent, FinancialState> {
  final ParentPortalRepository _repository;

  FinancialBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const FinancialState()) {
    on<FinancialStarted>(_onStarted);
    on<FinancialFilterChanged>(_onFilterChanged);
  }

  Future<void> _onStarted(
    FinancialStarted event,
    Emitter<FinancialState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final transactions = await _repository.getTransactions(
        childId: event.childId,
        filter: state.filter,
      );
      emit(state.copyWith(isLoading: false, transactions: transactions));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void _onFilterChanged(
    FinancialFilterChanged event,
    Emitter<FinancialState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
    add(const FinancialStarted());
  }
}
