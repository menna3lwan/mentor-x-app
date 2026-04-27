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
    final palette = MentorXThemeColorPalette.light;

    return BlocProvider(
      create: (context) => AssessmentsBloc(
        repository: context.read<ParentGradeRepository>(),
      )..add(AssessmentsStarted(childId)),
      child: Scaffold(
        backgroundColor: palette.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: palette.textPrimary, size: 20),
          ),
          title: Text(
            'Academic Performance',
            style: TextStyle(
              color: palette.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.refresh_rounded, color: palette.brandPrimary),
                onPressed: () {
                  context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId));
                },
              ),
            ),
            const Gap(8),
          ],
        ),
        body: BlocBuilder<AssessmentsBloc, AssessmentsState>(
          builder: (context, state) {
            if (state.status == AssessmentsStatus.loading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
                ),
              );
            }

            if (state.status == AssessmentsStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger),
                      const Gap(16),
                      Text(
                        'Failed to load grades',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: palette.textPrimary),
                      ),
                      const Gap(8),
                      Text(
                        state.errorMessage ?? 'An unexpected error occurred',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: palette.textSecondary),
                      ),
                      const Gap(24),
                      MentorXButton(
                        onPressed: () => context.read<AssessmentsBloc>().add(AssessmentsStarted(childId)),
                        label: 'Retry',
                        size: MentorXButtonSize.small,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.assessments.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: palette.backgroundSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.assessment_rounded, size: 48, color: palette.textTertiary.withValues(alpha: 0.3)),
                    ),
                    const Gap(20),
                    Text(
                      'No Assessments Yet',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: palette.textPrimary),
                    ),
                    const Gap(8),
                    Text(
                      'Evaluation data will appear here once submitted.',
                      style: TextStyle(color: palette.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              color: palette.brandPrimary,
              onRefresh: () async {
                context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId));
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                children: [
                  if (state.gradeSummary != null) ...[
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: palette.brandPrimary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'OVERALL PERFORMANCE',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              '${state.gradeSummary!.overallAverage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -2.0,
                              ),
                            ),
                            const Gap(24),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: state.gradeSummary!.distribution.entries.map((entry) {
                                  return Column(
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        'Grade',
                                        style: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(40),
                  ],
                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'Assessment History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: palette.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Gap(16),
                  ...state.assessments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final assessment = entry.value;
                    return FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 50 * index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: palette.backgroundSecondary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.description_rounded,
                              color: palette.brandPrimary,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            'Quiz Result • ID ${assessment.quizId}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: palette.textPrimary,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Score: ${assessment.score}/${assessment.totalMarks} • Passed: ${assessment.passed ? 'Yes' : 'No'}',
                              style: TextStyle(
                                fontSize: 13,
                                color: palette.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: (assessment.passed ? palette.statusSuccess : palette.statusDanger).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${assessment.percentage.toInt()}%',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: assessment.passed ? palette.statusSuccess : palette.statusDanger,
                              ),
                            ),
                          ),
                          onTap: () {
                            // Detail navigation
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
