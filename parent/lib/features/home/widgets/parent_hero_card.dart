import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../../core/routing/app_routes.dart';

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
    return AppHeroCard(
      title: 'Academic Standing',
      icon: Icons.analytics_outlined,
      colors: [
        context.brandPrimaryColor,
        context.textPrimaryColor,
      ],
      stats: [
        AppHeroStatItem(
          label: 'Avg Grade',
          value: '${summary.overview.avgGrade.toStringAsFixed(1)}%',
          onTap: () => AcademicMonitorRoute(childId: selectedChildId).go(context),
        ),
        AppHeroStatItem(
          label: 'Attendance',
          value: '${(summary.overview.avgAttendanceRate * 100).toStringAsFixed(0)}%',
          onTap: () => AttendanceMonitorRoute(childId: selectedChildId).go(context),
        ),
        AppHeroStatItem(
          label: 'Unpaid Invoices',
          value: summary.overview.unpaidInvoicesCount.toString(),
          onTap: () => FinancialMonitorRoute(childId: selectedChildId).go(context),
        ),
      ],
    );
  }
}
