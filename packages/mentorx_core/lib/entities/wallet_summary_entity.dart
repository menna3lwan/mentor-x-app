part of '../mentorx_core.dart';

final class WalletSummaryEntity extends Equatable {
  final double walletBalance;
  final int points;

  const WalletSummaryEntity({
    required this.walletBalance,
    required this.points,
  });

  @override
  List<Object?> get props => [walletBalance, points];
}
