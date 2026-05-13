import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: context.brandPrimaryColor.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                const WalletMainPageRoute().push(context);
              },
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.brandPrimaryColor,
                      context.brandSecondaryColor.withValues(alpha: 0.8),
                    ],
                    stops: const [0.3, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 140,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                                size: 14,
                              ),
                              const Gap(8),
                              Text(
                                context.t.home.dashboard.walletBalance.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Text(
                          context.t.core.price(amount: balance),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                            height: 1.0,
                          ),
                        ),
                        const Gap(24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.stars_rounded,
                                  color: context.brandPrimaryColor,
                                  size: 14,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                context.t.home.dashboard.points(
                                  count: points,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.2,
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
      ),
    );
  }
}
