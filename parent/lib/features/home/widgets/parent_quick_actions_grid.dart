import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class ParentQuickActionsGrid extends StatelessWidget {
  const ParentQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _QuickAction(
          index: 0,
          icon: Icons.calendar_today_rounded,
          label: 'Attendance',
          color: palette.brandPrimary,
          onTap: () {},
        ),
        _QuickAction(
          index: 1,
          icon: Icons.auto_stories_rounded,
          label: 'Courses',
          color: palette.brandSecondary,
          onTap: () {},
        ),
        _QuickAction(
          index: 2,
          icon: Icons.account_balance_wallet_rounded,
          label: 'Fees',
          color: palette.statusSuccess,
          onTap: () {},
        ),
        _QuickAction(
          index: 3,
          icon: Icons.chat_bubble_rounded,
          label: 'Messages',
          color: palette.statusWarning,
          onTap: () {},
        ),
        _QuickAction(
          index: 4,
          icon: Icons.bar_chart_rounded,
          label: 'Reports',
          color: const Color(0xFF6366F1), // Indigo
          onTap: () {},
        ),
        _QuickAction(
          index: 5,
          icon: Icons.event_note_rounded,
          label: 'Schedule',
          color: const Color(0xFFEC4899), // Pink
          onTap: () {},
        ),
        _QuickAction(
          index: 6,
          icon: Icons.emoji_events_rounded,
          label: 'Awards',
          color: const Color(0xFFF59E0B), // Amber
          onTap: () {},
        ),
        _QuickAction(
          index: 7,
          icon: Icons.support_agent_rounded,
          label: 'Support',
          color: palette.textTertiary,
          onTap: () {},
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.index,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.08),
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: palette.textPrimary,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
