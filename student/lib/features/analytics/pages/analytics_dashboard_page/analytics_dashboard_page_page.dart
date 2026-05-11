import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'bloc/analytics_dashboard_page_bloc.dart';
import 'widgets/widgets.dart';

final class AnalyticsDashboardPagePage extends StatelessWidget {
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

  const AnalyticsDashboardPagePage({
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
    final t = context.t.student['analytics'] as dynamic;
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildBody(context, t),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic t) {
    switch (status) {
      case AnalyticsDashboardStatus.initial:
      case AnalyticsDashboardStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case AnalyticsDashboardStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: context.statusDangerColor,
                size: 48,
              ),
              const Gap(16),
              Text(
                errorMessage ?? 'An error occurred',
                style: TextStyle(color: context.textPrimaryColor),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: onRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.brandPrimaryColor,
                  foregroundColor: context.textPrimaryColor,
                ),
                child: Text(context.t.ui.errors.retry),
              ),
            ],
          ),
        );
      case AnalyticsDashboardStatus.success:
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: context.brandSecondaryColor,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(MediaQuery.paddingOf(context).top),
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
                                  onTap: () => LeaderboardPageRoute(
                                    courseId: selectedCourseId,
                                  ).push(context),
                                ),
                              ),
                            const Gap(20),

                            // 2. Performance Timeline
                            if (performanceTimeline != null)
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 100),
                                child: PerformanceTimelineChart(
                                  data: performanceTimeline!,
                                ),
                              ),
                            const Gap(20),

                            // 3. Streak (Highlighted)
                            if (streak != null)
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 200),
                                child: StreakCard(streak: streak!),
                              ),
                            const Gap(20),

                            // 4. Activity Heatmap
                            if (activityHeatmap != null)
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 300),
                                child: ActivityHeatmapCard(
                                  data: activityHeatmap!,
                                ),
                              ),
                            const Gap(20),

                            // 5. Achievements
                            if (achievements != null)
                              FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 400),
                                child: AchievementsSection(
                                  achievements: achievements!,
                                ),
                              ),
                            const Gap(20),

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
              ),
            ],
          ),
        );
    }
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Performance Dashboard',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: context.brandPrimaryColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Your Academic Journey',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                color: context.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSelector(BuildContext context, dynamic t) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(bottom: 24),
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
            padding: const EdgeInsets.only(right: 10),
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
          color: isSelected ? null : context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : context.textSecondaryColor,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          left: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 400,
          ),
        ),
        Positioned(
          bottom: 200,
          right: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.1),
            size: 500,
          ),
        ),
        Positioned(
          top: 300,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
