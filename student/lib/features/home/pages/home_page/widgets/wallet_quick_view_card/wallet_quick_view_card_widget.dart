import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_core/mentorx_core.dart';

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
    final palette = MentorXThemeColorPalette.light;
    final balance = walletSummary?.walletBalance ?? 0;
    final points = walletSummary?.points ?? 0;

    return Skeletonizer(
      enabled: isLoading,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [palette.brandPrimary, palette.brandSecondary],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.home.dashboard.walletBalance,
                        style: TextStyle(
                          color: palette.textForeground.withValues(alpha: 0.8),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.t.core.price(amount: balance),
                        style: TextStyle(
                          color: palette.textForeground,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.t.home.dashboard.points(count: points),
                        style: TextStyle(
                          color: palette.textForeground.withValues(alpha: 0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: palette.textForeground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
