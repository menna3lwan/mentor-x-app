import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class WalletSummaryCardWidget extends StatelessWidget {
  final WalletSummaryEntity summary;
  final String title;
  final String currency;
  final String balanceLabel;
  final String spentLabel;
  final String pointsLabel;

  const WalletSummaryCardWidget({
    super.key,
    required this.summary,
    required this.title,
    required this.currency,
    required this.balanceLabel,
    required this.spentLabel,
    required this.pointsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: AppHeroCard(
        title: title,
        icon: Icons.account_balance_wallet_rounded,
        stats: [
          AppHeroStatItem(
            label: balanceLabel,
            value: _formatMoney(summary.walletBalance, currency),
            onTap: () {},
          ),
          AppHeroStatItem(
            label: spentLabel,
            value: _formatMoney(summary.spentThisMonth, currency),
            onTap: () {},
          ),
          AppHeroStatItem(
            label: pointsLabel,
            value: summary.points.clamp(0, 999999).toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// Compact money formatter. Handles NaN/infinity, clamps to a sensible
  /// non-negative range, and condenses large amounts (1.2k / 3.4M) so they
  /// stay inside the StatCard on small screens.
  static String _formatMoney(double raw, String currency) {
    if (raw.isNaN || raw.isInfinite) return '$currency 0';
    final value = raw < 0 ? 0.0 : raw;
    if (value >= 1000000) {
      return '$currency ${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 10000) {
      return '$currency ${(value / 1000).toStringAsFixed(1)}k';
    }
    return '$currency ${value.toStringAsFixed(0)}';
  }
}

class WalletSummaryCardSkeleton extends StatelessWidget {
  const WalletSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 140, borderRadius: 24);
  }
}
