import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/analytics_dashboard_bloc.dart';
import 'widgets/widgets.dart';

final class AnalyticsDashboardPage extends StatelessWidget {
  final AnalyticsDashboardStatus status;
  final List<EnrollmentEntity> courses;
  final String? selectedCourseId;
  final int? rank;
  final int? totalStudents;
  final double? studentAverage;
  final double? classAverage;
  final List<PerformanceSnapshotEntity>? performanceTimeline;
  final List<ActivityHeatmapEntity>? activityHeatmap;
  final List<AchievementEntity>? achievements;
  final StreakEntity? streak;
  final List<QuizSpeedMetricEntity>? quizSpeedMetrics;
  final String? errorMessage;
  final RefreshCallback onRefresh;
  final ValueChanged<String?> onCourseChanged;
  final StudentAnalyticsSummaryEntity? summary;

  const AnalyticsDashboardPage({
    super.key,
    required this.status,
    required this.courses,
    required this.selectedCourseId,
    this.rank,
    this.totalStudents,
    this.studentAverage,
    this.classAverage,
    this.performanceTimeline,
    this.activityHeatmap,
    this.achievements,
    this.streak,
    this.quizSpeedMetrics,
    this.errorMessage,
    required this.onRefresh,
    required this.onCourseChanged,
    this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.analytics;
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: _buildBody(context, t),
    );
  }

  Widget _buildBody(BuildContext context, dynamic t) {
    switch (status) {
      case AnalyticsDashboardStatus.initial:
      case AnalyticsDashboardStatus.loading:
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Gap(MediaQuery.paddingOf(context).top),
              const MentorXSkeleton(height: 80, borderRadius: 24),
              const Gap(24),
              const MentorXSkeleton(height: 200, borderRadius: 32),
              const Gap(24),
              const MentorXSkeleton(height: 150, borderRadius: 32),
              const Gap(24),
              const MentorXSkeleton(height: 100, borderRadius: 24),
            ],
          ),
        );
      case AnalyticsDashboardStatus.failure:
        return AppErrorView(
          message: errorMessage ?? t.leaderboardError,
          onRetry: onRefresh,
        );
      case AnalyticsDashboardStatus.success:
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: context.brandSecondaryColor,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, t),

                    // 0. Course Selector
                    if (courses.isNotEmpty) _buildCourseSelector(context, t),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // 1. Grade vs Peers
                          if (rank != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              child: GradeComparisonCard(
                                rank: rank!,
                                totalStudents: totalStudents ?? 0,
                                studentAverage: studentAverage ?? 0,
                                classAverage: classAverage ?? 0,
                                onTap: () => LeaderboardRoute(
                                  courseId: selectedCourseId,
                                ).push(context),
                              ),
                            ),
                          const Gap(24),

                          // 2. Performance Timeline
                          if (performanceTimeline != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 100),
                              child: PerformanceTimelineChart(
                                data: performanceTimeline!,
                              ),
                            ),
                          const Gap(24),

                          // 3. Streak (Highlighted)
                          if (streak != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 200),
                              child: StreakCard(streak: streak!),
                            ),
                          const Gap(24),

                          // 4. Activity Heatmap
                          if (activityHeatmap != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 300),
                              child: ActivityHeatmapCard(
                                data: activityHeatmap!,
                              ),
                            ),
                          const Gap(24),

                          // 5. Achievements
                          if (achievements != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 400),
                              child: AchievementsSection(
                                achievements: achievements!,
                              ),
                            ),
                          const Gap(24),

                          // 6. Quiz Speed
                          if (quizSpeedMetrics != null)
                            FadeInUp(
                              duration: const Duration(milliseconds: 500),
                              delay: const Duration(milliseconds: 500),
                              child: QuizSpeedCard(
                                metrics: quizSpeedMetrics!,
                              ),
                            ),
                          const Gap(40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              const Gap(8),
              MentorXIconButton(
                onPressed: () => context.pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.ghost,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.analytics.performanceDashboard.toUpperCase(),
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      context.t.analytics.academicJourney,
                      style: context.titleH1Style.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              MentorXIconButton(
                onPressed: () => const NotificationsRoute().push(context),
                icon: Icons.notifications_none_rounded,
                variant: MentorXIconButtonVariant.ghost,
                size: MentorXIconButtonSize.small,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseSelector(BuildContext context, dynamic t) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 16, bottom: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: courses.length + 1,
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final course = isAll ? null : courses[index - 1];
          final isSelected = isAll
              ? selectedCourseId == null
              : selectedCourseId == course?.id;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ModernFilterChip(
              label: isAll ? t.allCourses : course!.courseTitle ?? '',
              isSelected: isSelected,
              onTap: () => onCourseChanged(course?.id),
            ),
          );
        },
      ),
    );
  }
}

class _ModernFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    context.brandPrimaryColor,
                    context.brandSecondaryColor,
                  ],
                )
              : null,
          color: isSelected
              ? null
              : context.backgroundSecondaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.brandPrimaryColor.withValues(alpha: 0.2)
                : context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: context.bodyPrimaryStyle.copyWith(
            color: isSelected ? Colors.white : context.textSecondaryColor,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
