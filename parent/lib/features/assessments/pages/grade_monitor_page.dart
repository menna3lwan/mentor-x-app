import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/assessments_bloc.dart';

final class GradeMonitorPage extends StatelessWidget {
  final AssessmentsStatus status;
  final List<QuizAttemptEntity> assessments;
  final ParentGradeSummaryEntity? gradeSummary;
  final String? errorMessage;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;

  const GradeMonitorPage({
    super.key,
    required this.status,
    required this.assessments,
    required this.gradeSummary,
    required this.errorMessage,
    required this.onRefresh,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Academic Performance',
      onRefresh: () async => onRefresh(),
      actions: [
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (status == AssessmentsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == AssessmentsStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? 'Failed to load grades',
        onRetry: onRetry,
      );
    }

    if (assessments.isEmpty) {
      return AppEmptyView(
        title: 'No Assessments',
        message: 'Academic evaluation data will appear here once submitted.',
        icon: Icons.assessment_rounded,
        onAction: onRefresh,
        actionLabel: 'Refresh',
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (gradeSummary != null) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AppHeroCard(
              title: 'Overall Performance',
              icon: Icons.trending_up_rounded,
              stats: [
                AppHeroStatItem(
                  label: 'Average',
                  value: '${gradeSummary!.overallAverage.toStringAsFixed(1)}%',
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Graded',
                  value: gradeSummary!.graded.toString(),
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Pending',
                  value: gradeSummary!.pending.toString(),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Gap(32),
        ],
        
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: const AppSectionHeader(title: 'Assessment History'),
        ),
        const Gap(16),
        
        ...assessments.asMap().entries.map((entry) {
          final index = entry.key;
          final assessment = entry.value;
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * index),
            child: _AssessmentRecordCard(assessment: assessment),
          );
        }),
        
        const Gap(40),
      ],
    );
  }
}

class _AssessmentRecordCard extends StatelessWidget {
  final QuizAttemptEntity assessment;

  const _AssessmentRecordCard({required this.assessment});

  @override
  Widget build(BuildContext context) {
    final statusColor = assessment.passed ? context.statusSuccessColor : context.statusDangerColor;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.backgroundPrimaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.description_rounded,
            color: context.brandPrimaryColor,
            size: 24,
          ),
        ),
        title: Text(
          'Quiz Result • ID ${assessment.quizId}',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 15,
            color: context.textPrimaryColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Score: ${assessment.score}/${assessment.totalMarks} • ${assessment.passed ? "Passed" : "Failed"}',
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: StatusBadge(
          label: '${assessment.percentage.toInt()}%',
          color: statusColor,
          isSmall: true,
        ),
        onTap: () {
          // Detail navigation
        },
      ),
    );
  }
}
