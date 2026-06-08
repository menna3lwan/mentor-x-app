import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class OverallPerformanceCardWidget extends StatelessWidget {
  final ParentGradeSummaryEntity summary;
  final String title;
  final String averageLabel;
  final String gradedLabel;
  final String pendingLabel;

  const OverallPerformanceCardWidget({
    super.key,
    required this.summary,
    required this.title,
    required this.averageLabel,
    required this.gradedLabel,
    required this.pendingLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: AppHeroCard(
        title: title,
        icon: Icons.trending_up_rounded,
        stats: [
          AppHeroStatItem(
            label: averageLabel,
            value: _formatPercent(summary.overallAverage),
            onTap: () {},
          ),
          AppHeroStatItem(
            label: gradedLabel,
            value: summary.graded.clamp(0, 9999).toString(),
            onTap: () {},
          ),
          AppHeroStatItem(
            label: pendingLabel,
            value: summary.pending.clamp(0, 9999).toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// Clamps the percentage to [0, 100]. Defensive against APIs that
  /// occasionally send NaN/infinity or values outside the normal range.
  static String _formatPercent(double raw) {
    if (raw.isNaN || raw.isInfinite) return '0%';
    return '${raw.clamp(0.0, 100.0).toStringAsFixed(1)}%';
  }
}

class OverallPerformanceCardSkeleton extends StatelessWidget {
  const OverallPerformanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 140, borderRadius: 24);
  }
}
