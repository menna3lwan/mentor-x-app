import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'package:parent/core/core.dart';

class ParentHeroCard extends StatelessWidget {
  final ParentHomeSummaryEntity summary;
  final String selectedChildId;

  const ParentHeroCard({
    super.key,
    required this.summary,
    required this.selectedChildId,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: palette.brandPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.auto_graph_rounded, color: palette.brandPrimary, size: 22),
                ),
                const Gap(14),
                Text(
                  'Academic Standing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right_rounded, color: palette.textTertiary, size: 24),
              ],
            ),
            const Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Avg Grade',
                    value: '${summary.overview.avgGrade.toStringAsFixed(1)}%',
                    icon: Icons.grade_rounded,
                    color: palette.brandPrimary,
                    onTap: () => AcademicMonitorRoute(childId: selectedChildId).go(context),
                  ),
                ),
                Container(width: 1, height: 40, color: palette.borderPrimary.withValues(alpha: 0.1)),
                Expanded(
                  child: _StatItem(
                    label: 'Attendance',
                    value: '${(summary.overview.avgAttendanceRate * 100).toStringAsFixed(0)}%',
                    icon: Icons.calendar_today_rounded,
                    color: palette.brandSecondary,
                    onTap: () => AttendanceMonitorRoute(childId: selectedChildId).go(context),
                  ),
                ),
                Container(width: 1, height: 40, color: palette.borderPrimary.withValues(alpha: 0.1)),
                Expanded(
                  child: _StatItem(
                    label: 'Unpaid Fees',
                    value: summary.overview.unpaidInvoicesCount.toString(),
                    icon: Icons.account_balance_wallet_rounded,
                    color: palette.statusWarning,
                    onTap: () => FinancialMonitorRoute(childId: selectedChildId).go(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Gap(12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: palette.textTertiary,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
