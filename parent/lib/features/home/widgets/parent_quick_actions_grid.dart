import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class ParentQuickActionsGrid extends StatelessWidget {
  const ParentQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.9,
      children: [
        QuickActionItem(
          icon: Icons.calendar_today_rounded,
          label: 'Attendance',
          color: context.brandPrimaryColor,
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.auto_stories_rounded,
          label: 'Courses',
          color: context.brandSecondaryColor,
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.account_balance_wallet_rounded,
          label: 'Fees',
          color: context.statusSuccessColor,
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.chat_bubble_rounded,
          label: 'Messages',
          color: context.statusWarningColor,
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.bar_chart_rounded,
          label: 'Reports',
          color: const Color(0xFF6366F1), // Indigo
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.event_note_rounded,
          label: 'Schedule',
          color: const Color(0xFFEC4899), // Pink
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.emoji_events_rounded,
          label: 'Awards',
          color: const Color(0xFFF59E0B), // Amber
          onTap: () {},
        ),
        QuickActionItem(
          icon: Icons.support_agent_rounded,
          label: 'Support',
          color: context.textTertiaryColor,
          onTap: () {},
        ),
      ],
    );
  }
}
