import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../bloc/assessments_bloc.dart';

class GradeMonitorPage extends StatelessWidget {
  final String childId;

  const GradeMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentsBloc(
        repository: context.read<ParentGradeRepository>(),
      )..add(AssessmentsStarted(childId)),
      child: BlocBuilder<AssessmentsBloc, AssessmentsState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: 'Academic Performance',
            onRefresh: () async {
              context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AssessmentsState state) {
    if (state.status == AssessmentsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == AssessmentsStatus.failure) {
      return AppErrorView(
        message: state.errorMessage ?? 'Failed to load grades',
        onRetry: () => context.read<AssessmentsBloc>().add(AssessmentsStarted(childId)),
      );
    }

    if (state.assessments.isEmpty) {
      return AppEmptyView(
        title: 'No Assessments',
        message: 'Academic evaluation data will appear here once submitted.',
        icon: Icons.assessment_rounded,
        onAction: () => context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId)),
        actionLabel: 'Refresh',
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (state.gradeSummary != null) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AppHeroCard(
              title: 'Overall Performance',
              icon: Icons.trending_up_rounded,
              stats: [
                AppHeroStatItem(
                  label: 'Average',
                  value: '${state.gradeSummary!.overallAverage.toStringAsFixed(1)}%',
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Graded',
                  value: state.gradeSummary!.graded.toString(),
                  onTap: () {},
                ),
                AppHeroStatItem(
                  label: 'Pending',
                  value: state.gradeSummary!.pending.toString(),
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
        
        ...state.assessments.asMap().entries.map((entry) {
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
