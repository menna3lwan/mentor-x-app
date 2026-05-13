import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import 'bloc/course_detail_page_bloc.dart';
import 'widgets/widgets.dart';

final class CourseDetailPagePage extends StatelessWidget {
  final CourseEntity? course;
  final List<SessionEntity> sessions;
  final Map<String, List<SessionItemEntity>> sessionItems;
  final Map<String, List<WeekEntity>> sessionWeeks;
  final EnrollmentEntity? enrollment;
  final CourseDetailTab selectedTab;
  final bool isCourseLoading;
  final bool isSessionsLoading;
  final bool isEnrolling;
  final bool isEnrolled;
  final String? errorMessage;
  final ValueChanged<CourseDetailTab> onTabChanged;
  final VoidCallback onEnrollTap;
  final ValueChanged<SessionItemEntity> onSessionItemTap;
  final Future<void> Function() onRefresh;

  const CourseDetailPagePage({
    super.key,
    required this.course,
    required this.sessions,
    required this.sessionItems,
    required this.sessionWeeks,
    required this.enrollment,
    required this.selectedTab,
    required this.isCourseLoading,
    required this.isSessionsLoading,
    required this.isEnrolling,
    required this.isEnrolled,
    required this.errorMessage,
    required this.onTabChanged,
    required this.onEnrollTap,
    required this.onSessionItemTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Positioned.fill(child: _buildContent(context)),
          if (course != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _EnrollmentBar(
                course: course!,
                enrollment: enrollment,
                isEnrolling: isEnrolling,
                isEnrolled: isEnrolled,
                onEnrollTap: onEnrollTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (errorMessage != null) {
      return AppErrorView(
        message: errorMessage!,
        onRetry: onRefresh,
      );
    }

    if (isCourseLoading) {
      return Column(
        children: [
          Gap(MediaQuery.paddingOf(context).top + 20),
          _buildHeader(context),
          const Padding(
            padding: EdgeInsets.all(20),
            child: MentorXSkeleton(height: 250, borderRadius: 24),
          ),
          const Gap(20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MentorXSkeleton(height: 50, borderRadius: 24),
          ),
          const Gap(20),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 3,
              separatorBuilder: (_, _) => const Gap(12),
              itemBuilder: (_, _) =>
                  const MentorXSkeleton(height: 80, borderRadius: 16),
            ),
          ),
        ],
      );
    }

    if (course == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.brandPrimaryColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(MediaQuery.paddingOf(context).top + 20),
            _buildHeader(context),
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: CourseInfoHeader(
                course: course!,
                enrollment: enrollment,
              ),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: _DetailTabBar(
                selectedTab: selectedTab,
                onTabChanged: onTabChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: selectedTab == CourseDetailTab.description
                  ? _DescriptionTab(course: course!)
                  : _SessionsTab(
                      sessions: sessions,
                      sessionWeeks: sessionWeeks,
                      sessionItems: sessionItems,
                      isLoading: isSessionsLoading,
                      onItemTap: onSessionItemTap,
                    ),
            ),
            const Gap(140), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'COURSE DETAILS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    context.t.course.courseDetail,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
                    ),
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

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
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
    return Container(
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
    );
  }
}

final class _DetailTabBar extends StatelessWidget {
  final CourseDetailTab selectedTab;
  final ValueChanged<CourseDetailTab> onTabChanged;

  const _DetailTabBar({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: CourseDetailTab.values.map((tab) {
          final isSelected = tab == selectedTab;
          final label = switch (tab) {
            CourseDetailTab.description =>
              context.t.course.tabs.description,
            CourseDetailTab.sessions => context.t.course.tabs.sessions,
          };

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            context.brandPrimaryColor,
                            context.brandSecondaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w900
                        : FontWeight.w800,
                    color: isSelected
                        ? Colors.white
                        : context.textPrimaryColor.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

final class _DescriptionTab extends StatelessWidget {
  final CourseEntity course;

  const _DescriptionTab({required this.course});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.course.detail.aboutCourse,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(16),
            if (course.subtitle != null)
              Text(
                course.subtitle!,
                style: TextStyle(
                  fontSize: 15,
                  color: context.textSecondaryColor,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const Gap(24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _InfoChip(
                  icon: Icons.play_circle_filled_rounded,
                  label:
                      '${course.totalVideos} ${context.t.course.detail.videos}',
                ),
                _InfoChip(
                  icon: Icons.timer_rounded,
                  label:
                      '${course.totalDurationMinutes} ${context.t.course.detail.minutes}',
                ),
                _InfoChip(
                  icon: Icons.people_rounded,
                  label:
                      '${course.enrolledCount} ${context.t.course.detail.students}',
                ),
                _InfoChip(
                  icon: Icons.auto_stories_rounded,
                  label:
                      '${course.totalSessions} ${context.t.course.detail.sessions}',
                ),
                if (course.pointsReward > 0)
                  _InfoChip(
                    icon: Icons.auto_awesome_rounded,
                    label: '${course.pointsReward} Points Reward',
                    isHighlight: true,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlight;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlight
            ? context.brandPrimaryColor.withValues(alpha: 0.1)
            : context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isHighlight
              ? context.brandPrimaryColor.withValues(alpha: 0.2)
              : context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isHighlight
                  ? context.brandPrimaryColor
                  : context.brandPrimaryColor.withValues(alpha: 0.7),
            ),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: isHighlight
                    ? context.brandPrimaryColor
                    : context.textPrimaryColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SessionsTab extends StatelessWidget {
  final List<SessionEntity> sessions;
  final Map<String, List<WeekEntity>> sessionWeeks;
  final Map<String, List<SessionItemEntity>> sessionItems;
  final bool isLoading;
  final ValueChanged<SessionItemEntity> onItemTap;

  const _SessionsTab({
    required this.sessions,
    required this.sessionWeeks,
    required this.sessionItems,
    required this.isLoading,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        children: List.generate(
          3,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: MentorXSkeleton(height: 70, borderRadius: 24),
          ),
        ),
      );
    }

    if (sessions.isEmpty) {
      return AppEmptyView(
        title: context.t.course.errors.failedToLoadSessions,
        message: 'Try refreshing the page', // Fallback message
        icon: Icons.folder_open_rounded,
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: sessions.length,
      separatorBuilder: (_, _) => const Gap(12),
      itemBuilder: (context, index) {
        final session = sessions[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: SessionExpansionTile(
            session: session,
            weeks: sessionWeeks[session.id] ?? const [],
            items: sessionItems[session.id] ?? const [],
            onItemTap: onItemTap,
          ),
        );
      },
    );
  }
}

final class _EnrollmentBar extends StatelessWidget {
  final CourseEntity course;
  final EnrollmentEntity? enrollment;
  final bool isEnrolling;
  final bool isEnrolled;
  final VoidCallback onEnrollTap;

  const _EnrollmentBar({
    required this.course,
    required this.enrollment,
    required this.isEnrolling,
    required this.isEnrolled,
    required this.onEnrollTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
          border: Border(
            top: BorderSide(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    if (!isEnrolled)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (course.isFree)
                            Text(
                              context.t.course.detail.free,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: context.statusSuccessColor,
                                letterSpacing: -1,
                              ),
                            )
                          else ...[
                            Text(
                              '${course.price.toInt()} ${context.t.core.currency}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: context.textPrimaryColor,
                                letterSpacing: -1,
                              ),
                            ),
                            if (course.oldPrice != null)
                              Text(
                                '${course.oldPrice!.toInt()} ${context.t.core.currency}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: context.textTertiaryColor,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                          ],
                        ],
                      )
                    else
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.t.course.detail.yourProgress.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: context.textTertiaryColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              context.t.course.detail.completePercent(
                                percent: (enrollment?.progressPercent ?? 0).toInt(),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: context.brandPrimaryColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    _buildActionButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
  ) {
    if (isEnrolled) {
      final status = enrollment!.status;
      return MentorXButton(
        width: 180,
        onPressed: status == EnrollmentStatus.active ? () {} : null,
        label: status == EnrollmentStatus.active
            ? context.t.course.detail.continueStudying
            : status == EnrollmentStatus.completed
            ? context.t.course.detail.courseCompleted
            : context.t.course.detail.courseExpired,
        color: status == EnrollmentStatus.active
            ? context.brandSecondaryColor
            : status == EnrollmentStatus.completed
            ? context.statusSuccessColor
            : context.statusDangerColor,
      );
    }

    return MentorXButton(
      width: 180,
      onPressed: onEnrollTap,
      loading: isEnrolling,
      label: context.t.course.detail.enrollNow,
      color: context.brandPrimaryColor,
    );
  }
}
