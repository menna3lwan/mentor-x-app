part of 'package:mentorx_core/mentorx_core.dart';

class WalletSummaryEntity extends Equatable {
  final double walletBalance;
  final int points;
  final double spentThisMonth;
  final double totalCreditsThisMonth;
  final int totalTransactions;

  const WalletSummaryEntity({
    required this.walletBalance,
    required this.points,
    this.spentThisMonth = 0,
    this.totalCreditsThisMonth = 0,
    this.totalTransactions = 0,
  });

  static const placeholder = WalletSummaryEntity(
    walletBalance: 0.0,
    points: 0,
  );

  @override
  List<Object?> get props => [
        walletBalance,
        points,
        spentThisMonth,
        totalCreditsThisMonth,
        totalTransactions,
      ];

  WalletSummaryEntity copyWith({
    double? walletBalance,
    int? points,
    double? spentThisMonth,
    double? totalCreditsThisMonth,
    int? totalTransactions,
  }) {
    return WalletSummaryEntity(
      walletBalance: walletBalance ?? this.walletBalance,
      points: points ?? this.points,
      spentThisMonth: spentThisMonth ?? this.spentThisMonth,
      totalCreditsThisMonth: totalCreditsThisMonth ?? this.totalCreditsThisMonth,
      totalTransactions: totalTransactions ?? this.totalTransactions,
    );
  }
}
