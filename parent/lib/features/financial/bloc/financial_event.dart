part of 'financial_bloc.dart';

sealed class FinancialEvent extends Equatable {
  const FinancialEvent();

  @override
  List<Object?> get props => [];
}

final class FinancialStarted extends FinancialEvent {
  final String? childId;

  const FinancialStarted({this.childId});

  @override
  List<Object?> get props => [childId];
}

final class FinancialFilterChanged extends FinancialEvent {
  final String filter;

  const FinancialFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}
