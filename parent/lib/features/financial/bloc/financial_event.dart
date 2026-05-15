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

final class FinancialRefreshRequested extends FinancialEvent {
  final String? childId;
  const FinancialRefreshRequested({this.childId});

  @override
  List<Object?> get props => [childId];
}

final class FinancialRetrySectionRequested extends FinancialEvent {
  final FinancialSection section;
  const FinancialRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
