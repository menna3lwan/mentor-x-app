import 'package:flutter/material.dart';
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
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic Standing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(
                  label: 'Avg Grade',
                  value: '${summary.overview.avgGrade.toStringAsFixed(1)}%',
                  onTap: () => AcademicMonitorRoute(childId: selectedChildId).go(context),
                ),
                _StatItem(
                  label: 'Attendance',
                  value: '${(summary.overview.avgAttendanceRate * 100).toStringAsFixed(0)}%',
                  onTap: () => AttendanceMonitorRoute(childId: selectedChildId).go(context),
                ),
                _StatItem(
                  label: 'Unpaid Invoices',
                  value: summary.overview.unpaidInvoicesCount.toString(),
                  onTap: () => FinancialMonitorRoute(childId: selectedChildId).go(context),
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
  final VoidCallback onTap;

  const _StatItem({
    required this.label, 
    required this.value, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
