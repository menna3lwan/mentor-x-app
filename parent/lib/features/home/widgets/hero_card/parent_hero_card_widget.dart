import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

/// Headline "Academic Standing" card with three at-a-glance stats:
/// average grade, attendance rate, and unpaid fees.
class ParentHeroCardWidget extends StatelessWidget {
  final ParentHomeOverviewEntity overview;
  final String title;
  final String avgGradeLabel;
  final String attendanceLabel;
  final String unpaidFeesLabel;

  const ParentHeroCardWidget({
    super.key,
    required this.overview,
    required this.title,
    required this.avgGradeLabel,
    required this.attendanceLabel,
    required this.unpaidFeesLabel,
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
                child: Icon(
                  Icons.auto_graph_rounded,
                  color: context.brandPrimaryColor,
                  size: 20,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: avgGradeLabel,
                  value: _formatPercent(overview.avgGrade),
                  icon: Icons.grade_rounded,
                  iconColor: context.brandPrimaryColor,
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCard(
                  label: attendanceLabel,
                  value: _formatPercent(overview.avgAttendanceRate * 100,
                      decimals: 0),
                  icon: Icons.calendar_today_rounded,
                  iconColor: context.brandSecondaryColor,
                ),
              ),
              const Gap(12),
              Expanded(
                child: StatCard(
                  label: unpaidFeesLabel,
                  value: overview.unpaidInvoicesCount
                      .clamp(0, 9999)
                      .toString(),
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

/// Skeleton placeholder shown while the summary section is loading.
class ParentHeroCardSkeleton extends StatelessWidget {
  const ParentHeroCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        MentorXSkeleton(width: 180, height: 22, borderRadius: 6),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: MentorXSkeleton(height: 88, borderRadius: 20)),
            SizedBox(width: 12),
            Expanded(child: MentorXSkeleton(height: 88, borderRadius: 20)),
            SizedBox(width: 12),
            Expanded(child: MentorXSkeleton(height: 88, borderRadius: 20)),
          ],
        ),
      ],
    );
  }
}
