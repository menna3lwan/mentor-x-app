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
            value: '$currency ${summary.walletBalance.toStringAsFixed(0)}',
            onTap: () {},
          ),
          AppHeroStatItem(
            label: spentLabel,
            value: '$currency ${summary.spentThisMonth.toStringAsFixed(0)}',
            onTap: () {},
          ),
          AppHeroStatItem(
            label: pointsLabel,
            value: summary.points.toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class WalletSummaryCardSkeleton extends StatelessWidget {
  const WalletSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 140, borderRadius: 24);
  }
}
