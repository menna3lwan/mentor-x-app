import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ParentQuickActionsGrid extends StatelessWidget {
  const ParentQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            QuickActionItem(
              icon: Icons.assignment_outlined,
              label: 'Attendance',
              color: context.brandPrimaryColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.auto_stories_outlined,
              label: 'Courses',
              color: context.brandSecondaryColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Wallet',
              color: context.statusSuccessColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.chat_bubble_outline,
              label: 'Chat',
              color: context.statusWarningColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.bar_chart_outlined,
              label: 'Reports',
              color: context.statusWarningColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.calendar_month_outlined,
              label: 'Schedule',
              color: context.brandPrimaryColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.emoji_events_outlined,
              label: 'Rewards',
              color: context.statusDangerColor,
              onTap: () {},
            ),
            QuickActionItem(
              icon: Icons.help_outline,
              label: 'Support',
              color: context.textTertiaryColor,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
