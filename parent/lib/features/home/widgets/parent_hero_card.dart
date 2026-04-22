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
    return GradientCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      colors: [
        const Color(0xFF183764),
        const Color(0xFF1E293B),
      ],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Academic Standing',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Icon(Icons.analytics_outlined, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 20),
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
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }
}
