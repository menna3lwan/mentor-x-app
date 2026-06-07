import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

final class AssignmentGradeDetailParentViewPage extends StatelessWidget {
  final QuizAttemptEntity attempt;

  const AssignmentGradeDetailParentViewPage({
    super.key,
    required this.attempt,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Grade Details',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: AppHeroCard(
                title: 'ASSESSMENT INFO',
                icon: Icons.assignment_turned_in_rounded,
                stats: [
                  AppHeroStatItem(
                    label: 'Score',
                    value: '${attempt.score}/${attempt.totalMarks}',
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: 'Percentage',
                    value: '${attempt.percentage.toInt()}%',
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: 'Status',
                    value: attempt.status.name.toUpperCase(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Gap(32),
            
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: const AppSectionHeader(title: 'Additional Details'),
            ),
            const Gap(16),
            
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    _InfoRow(label: 'Quiz ID', value: attempt.quizId),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    if (attempt.submittedAt != null) ...[
                      _InfoRow(label: 'Submitted At', value: _formatDate(attempt.submittedAt!)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(),
                      ),
                    ],
                    _InfoRow(label: 'Pass Criteria', value: '50%'),
                  ],
                ),
              ),
            ),
            
            const Gap(40),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
