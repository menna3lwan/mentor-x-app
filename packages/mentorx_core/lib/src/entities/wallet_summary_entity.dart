part of '../../mentorx_core.dart';

final class WalletSummaryEntity extends Equatable {
  final double walletBalance;
  final int points;

  const WalletSummaryEntity({
    required this.walletBalance,
    required this.points,
  });


  static final placeholder = WalletSummaryEntity(
    walletBalance: 0.0,
    points: 0,
  );
  @override
  List<Object?> get props => [walletBalance, points];
}
