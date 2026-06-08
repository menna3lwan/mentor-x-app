import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/analytics_bloc.dart';
import '../widgets/analytics_charts.dart';
import '../widgets/analytics_section_card.dart';

/// Top-level analytics dashboard for a selected child. Wraps [AnalyticsBloc]
/// + listens for presentation events + composes the six section cards.
class AnalyticsMonitorPage extends StatelessWidget {
  final String childId;
  const AnalyticsMonitorPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsBloc(
        repository: context.read<ParentAnalyticsRepository>(),
      )..add(AnalyticsStarted(childId)),
      child: _AnalyticsView(childId: childId),
    );
  }
}

class _AnalyticsView extends StatelessWidget {
  final String childId;
  const _AnalyticsView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<AnalyticsBloc, AnalyticsPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case AnalyticsFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case AnalyticsUnauthorizedPresentationEvent():
            MentorXUI.showToast(
              message: t.analytics.unauthorized,
              isError: true,
            );
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: AppDashboardScaffold(
        title: t.analytics.pageTitle,
        onRefresh: () async => context.read<AnalyticsBloc>().add(
          AnalyticsRefreshRequested(childId),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _GradeComparisonCard(),
              const Gap(16),
              const _CourseProgressCard(),
              const Gap(16),
              const _ActiveHoursCard(),
              const Gap(16),
              const _StreakCard(),
              const Gap(16),
              const _AchievementsCard(),
              const Gap(16),
              const _QuizSpeedCard(),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── Section cards ────────────────────────────────

class _GradeComparisonCard extends StatelessWidget {
  const _GradeComparisonCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.gradeComparison != b.gradeComparison,
      builder: (context, state) {
        final section = state.gradeComparison;
        return AnalyticsSectionCard(
          title: t.analytics.sectionGradeComparison,
          trailing: section.isLoaded && section.data!.totalStudents > 0
              ? Text(
                  t.analytics.rankLabel(
                    rank: section.data!.rank,
                    total: section.data!.totalStudents,
                  ),
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                )
              : null,
          child: _sectionChild<ParentChildGradeComparisonEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(
                AnalyticsSection.gradeComparison,
              ),
            ),
            isEmpty: (d) => d.rows.isEmpty,
            builder: (d) => Column(
              children: [
                for (var i = 0; i < d.rows.length; i++) ...[
                  if (i > 0) const Gap(12),
                  GradeComparisonRowView(
                    label: d.rows[i].label,
                    childScore: d.rows[i].childScore,
                    classAverage: d.rows[i].classAverage,
                    childLabel: t.analytics.childAverageLabel,
                    classLabel: t.analytics.classAverageLabel,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CourseProgressCard extends StatelessWidget {
  const _CourseProgressCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.courseProgress != b.courseProgress,
      builder: (context, state) {
        final section = state.courseProgress;
        return AnalyticsSectionCard(
          title: t.analytics.sectionCourseProgress,
          child: _sectionChild<ParentChildCourseProgressEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(
                AnalyticsSection.courseProgress,
              ),
            ),
            isEmpty: (d) => d.courses.isEmpty,
            builder: (d) => Column(
              children: [
                for (var i = 0; i < d.courses.length; i++) ...[
                  if (i > 0) const Gap(14),
                  CourseProgressRowView(
                    courseName: d.courses[i].courseName,
                    progressPercent: d.courses[i].progressPercent,
                    sessionsLabel: t.analytics.completedSessionsLabel(
                      completed: d.courses[i].sessionsCompleted,
                      total: d.courses[i].sessionsTotal,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActiveHoursCard extends StatelessWidget {
  const _ActiveHoursCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.activeHours != b.activeHours,
      builder: (context, state) {
        final section = state.activeHours;
        return AnalyticsSectionCard(
          title: t.analytics.sectionActiveHours,
          child: _sectionChild<ParentChildActiveHoursEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(
                AnalyticsSection.activeHours,
              ),
            ),
            isEmpty: (d) => d.days.isEmpty,
            builder: (d) {
              final maxMinutes = d.days.fold<int>(
                0,
                (m, x) => x.minutes > m ? x.minutes : m,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ActiveHoursBarChart(
                    maxMinutes: maxMinutes,
                    unitLabel: '',
                    points: d.days
                        .map(
                          (e) => (
                            label: DateFormat('E').format(e.date),
                            minutes: e.minutes,
                          ),
                        )
                        .toList(),
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.analytics.averagePerDay(
                            minutes: d.averageMinutesPerDay,
                          ),
                          style: TextStyle(
                            color: context.textSecondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        t.analytics.totalMinutes(minutes: d.totalMinutes),
                        style: TextStyle(
                          color: context.textSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.streak != b.streak,
      builder: (context, state) {
        final section = state.streak;
        return AnalyticsSectionCard(
          title: t.analytics.sectionStreak,
          child: _sectionChild<StreakEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(AnalyticsSection.streak),
            ),
            isEmpty: (d) => d.currentStreak == 0 && d.longestStreak == 0,
            builder: (d) => Column(
              children: [
                StreakStatsView(
                  currentStreak: d.currentStreak,
                  longestStreak: d.longestStreak,
                  currentLabel: t.analytics.currentStreak,
                  longestLabel: t.analytics.longestStreak,
                  daysLabelBuilder: (days) =>
                      t.analytics.streakDays(days: days),
                ),
                if (d.lastActivityAt != null) ...[
                  const Gap(12),
                  Text(
                    t.analytics.lastActive(
                      time: DateFormat.MMMd().add_jm().format(
                        d.lastActivityAt!,
                      ),
                    ),
                    style: TextStyle(
                      color: context.textTertiaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AchievementsCard extends StatelessWidget {
  const _AchievementsCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.achievements != b.achievements,
      builder: (context, state) {
        final section = state.achievements;
        return AnalyticsSectionCard(
          title: t.analytics.sectionAchievements,
          trailing: section.isLoaded
              ? Text(
                  t.analytics.unlockedCount(
                    unlocked: section.data!.totalUnlocked,
                  ),
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                )
              : null,
          child: _sectionChild<ParentChildAchievementsEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(
                AnalyticsSection.achievements,
              ),
            ),
            isEmpty: (d) => d.achievements.isEmpty,
            builder: (d) => Column(
              children: [
                for (var i = 0; i < d.achievements.length; i++) ...[
                  if (i > 0) const Gap(8),
                  AchievementTileView(
                    title: d.achievements[i].title,
                    description: d.achievements[i].description,
                    isUnlocked: d.achievements[i].isUnlocked,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuizSpeedCard extends StatelessWidget {
  const _QuizSpeedCard();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      buildWhen: (a, b) => a.quizSpeed != b.quizSpeed,
      builder: (context, state) {
        final section = state.quizSpeed;
        return AnalyticsSectionCard(
          title: t.analytics.sectionQuizSpeed,
          child: _sectionChild<ParentChildQuizSpeedEntity>(
            context: context,
            section: section,
            t: t,
            onRetry: () => context.read<AnalyticsBloc>().add(
              const AnalyticsRetrySectionRequested(
                AnalyticsSection.quizSpeed,
              ),
            ),
            isEmpty: (d) =>
                d.totalQuizzes == 0 && d.overallAverageSecondsPerQuestion == 0,
            builder: (d) => QuizSpeedSummaryView(
              averageSecondsPerQuestion: d.overallAverageSecondsPerQuestion,
              totalQuizzes: d.totalQuizzes,
              averageLabel: t.analytics.averageQuizSpeed(
                seconds: d.overallAverageSecondsPerQuestion.toStringAsFixed(1),
              ),
              countLabel: t.analytics.quizCountLabel(count: d.totalQuizzes),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────── Helpers ───────────────────────────────────────

Widget _sectionChild<T>({
  required BuildContext context,
  required AnalyticsAsyncSection<T> section,
  required TranslationsParentEn t,
  required VoidCallback onRetry,
  required bool Function(T data) isEmpty,
  required Widget Function(T data) builder,
}) {
  if (section.isLoading || section.isInitial) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          MentorXSkeleton(
            width: double.infinity,
            height: 14,
            borderRadius: 6,
          ),
          SizedBox(height: 8),
          MentorXSkeleton(
            width: double.infinity,
            height: 14,
            borderRadius: 6,
          ),
          SizedBox(height: 8),
          MentorXSkeleton(
            width: double.infinity,
            height: 14,
            borderRadius: 6,
          ),
        ],
      ),
    );
  }
  if (section.isFailure) {
    return AnalyticsFailureState(
      message: section.errorMessage ?? t.analytics.loadFailed,
      retryLabel: t.analytics.errorRetry,
      onRetry: onRetry,
    );
  }
  final data = section.data;
  if (data == null) {
    return AnalyticsEmptyState(
      title: t.analytics.emptySectionTitle,
      hint: t.analytics.emptySectionHint,
    );
  }
  if (isEmpty(data)) {
    return AnalyticsEmptyState(
      title: t.analytics.emptySectionTitle,
      hint: t.analytics.emptySectionHint,
    );
  }
  return builder(data);
}
