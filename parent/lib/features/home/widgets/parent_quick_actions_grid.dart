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
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _QuickActionCard(
          icon: Icons.calendar_today_rounded,
          label: 'Attendance',
          color: context.brandPrimaryColor,
          onTap: () {},
          index: 0,
        ),
        _QuickActionCard(
          icon: Icons.auto_stories_rounded,
          label: 'Courses',
          color: context.brandSecondaryColor,
          onTap: () {},
          index: 1,
        ),
        _QuickActionCard(
          icon: Icons.account_balance_wallet_rounded,
          label: 'Fees',
          color: context.statusSuccessColor,
          onTap: () {},
          index: 2,
        ),
        _QuickActionCard(
          icon: Icons.chat_bubble_rounded,
          label: 'Messages',
          color: context.statusWarningColor,
          onTap: () {},
          index: 3,
        ),
        _QuickActionCard(
          icon: Icons.bar_chart_rounded,
          label: 'Reports',
          color: const Color(0xFF6366F1),
          onTap: () {},
          index: 4,
        ),
        _QuickActionCard(
          icon: Icons.event_note_rounded,
          label: 'Schedule',
          color: const Color(0xFFEC4899),
          onTap: () {},
          index: 5,
        ),
        _QuickActionCard(
          icon: Icons.emoji_events_rounded,
          label: 'Awards',
          color: const Color(0xFFF59E0B),
          onTap: () {},
          index: 6,
        ),
        _QuickActionCard(
          icon: Icons.support_agent_rounded,
          label: 'Support',
          color: context.textTertiaryColor,
          onTap: () {},
          index: 7,
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final int index;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 50 * index),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: context.textSecondaryColor,
                letterSpacing: -0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
