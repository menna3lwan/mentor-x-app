import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_student/core/core.dart';

final class WalletQuickViewCardWidget extends StatelessWidget {
  final WalletSummaryEntity? walletSummary;
  final bool isLoading;

  const WalletQuickViewCardWidget({
    super.key,
    required this.walletSummary,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final balance = walletSummary?.walletBalance ?? 0;
    final points = walletSummary?.points ?? 0;

    return Skeletonizer(
      enabled: isLoading,
      child: AppHeroCard(
        title: context.t.home.dashboard.walletBalance.toUpperCase(),
        icon: Icons.account_balance_wallet_rounded,
        colors: [
          context.brandPrimaryColor,
          context.brandPrimaryColor.withValues(alpha: 0.85),
        ],
        stats: [
          AppHeroStatItem(
            value: context.t.core.price(amount: balance),
            label: 'Balance',
            onTap: () {
              const WalletMainRoute().push(context);
            },
          ),
          AppHeroStatItem(
            value: context.t.home.dashboard.points(count: points),
            label: 'Points',
            onTap: () {
              const RewardsCatalogRoute().push(context);
            },
          ),
          AppHeroStatItem(
            value: 'Level 5',
            label: 'Rank',
            onTap: () {
              const LeaderboardRoute().push(context);
            },
          ),
        ],
      ),
    );
  }
}
