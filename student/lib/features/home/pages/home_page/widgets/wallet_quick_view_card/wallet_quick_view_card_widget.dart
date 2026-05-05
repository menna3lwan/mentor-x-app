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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: palette.brandPrimary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    palette.brandPrimary,
                    palette.brandSecondary,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 100,
                      color: palette.textForeground.withOpacity(0.1),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: palette.textForeground.withOpacity(
                                    0.9,
                                  ),
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  context.t.home.dashboard.walletBalance,
                                  style: TextStyle(
                                    color: palette.textForeground.withOpacity(
                                      0.9,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              context.t.core.price(amount: balance),
                              style: TextStyle(
                                color: palette.textForeground,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: palette.textForeground.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.stars_rounded,
                                    color: palette.textForeground,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    context.t.home.dashboard.points(
                                      count: points,
                                    ),
                                    style: TextStyle(
                                      color: palette.textForeground,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
