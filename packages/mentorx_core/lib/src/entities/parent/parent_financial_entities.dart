part of 'package:mentorx_core/mentorx_core.dart';

class MonthlySpendingEntry extends Equatable {
  final String month; // "2025-07"
  final double amount;

  const MonthlySpendingEntry({
    required this.month,
    required this.amount,
  });

  @override
  List<Object?> get props => [month, amount];
}

class ParentWalletAnalyticsEntity extends Equatable {
  final List<MonthlySpendingEntry> monthlySpending;
  final Map<String, double> categoryBreakdown;

  const ParentWalletAnalyticsEntity({
    required this.monthlySpending,
    required this.categoryBreakdown,
  });

  static const placeholder = ParentWalletAnalyticsEntity(
    monthlySpending: [],
    categoryBreakdown: {},
  );

  @override
  List<Object?> get props => [monthlySpending, categoryBreakdown];
}
