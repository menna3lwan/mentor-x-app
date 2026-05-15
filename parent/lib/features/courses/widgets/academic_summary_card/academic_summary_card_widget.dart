import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

class AcademicSummaryCardWidget extends StatelessWidget {
  final ParentGradeSummaryEntity summary;
  final String title;
  final String averageLabel;
  final String gradedLabel;
  final String pendingLabel;

  const AcademicSummaryCardWidget({
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
        icon: Icons.auto_graph_rounded,
        stats: [
          AppHeroStatItem(
            label: averageLabel,
            value: '${summary.overallAverage.toStringAsFixed(1)}%',
            onTap: () {},
          ),
          AppHeroStatItem(
            label: gradedLabel,
            value: summary.graded.toString(),
            onTap: () {},
          ),
          AppHeroStatItem(
            label: pendingLabel,
            value: summary.pending.toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class AcademicSummaryCardSkeleton extends StatelessWidget {
  const AcademicSummaryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const MentorXSkeleton(height: 140, borderRadius: 24);
  }
}
