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
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.auto_graph_rounded,
                    color: context.brandPrimaryColor, size: 20),
              ),
              const Gap(12),
              Text(
                'Academic Standing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Avg Grade',
                  value: '${summary.overview.avgGrade.toStringAsFixed(1)}%',
                  icon: Icons.grade_rounded,
                  iconColor: context.brandPrimaryColor,
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCard(
                  label: 'Attendance',
                  value:
                      '${(summary.overview.avgAttendanceRate * 100).toStringAsFixed(0)}%',
                  icon: Icons.calendar_today_rounded,
                  iconColor: context.brandSecondaryColor,
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCard(
                  label: 'Unpaid Fees',
                  value: summary.overview.unpaidInvoicesCount.toString(),
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: context.statusWarningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
