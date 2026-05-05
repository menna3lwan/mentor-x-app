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
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.course.courseDetail),
      ),
      body: _buildBody(context, palette),
      bottomNavigationBar: course != null
          ? FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: _EnrollmentBar(
                course: course!,
                enrollment: enrollment,
                isEnrolling: isEnrolling,
                isEnrolled: isEnrolled,
                onEnrollTap: onEnrollTap,
              ),
            )
          : null,
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: palette.statusDanger,
            ),
            const Gap(12),
            Text(
              errorMessage!,
              style: TextStyle(color: palette.statusDanger),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (isCourseLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (course == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      sessionItems: sessionItems,
                      isLoading: isSessionsLoading,
                      onItemTap: onSessionItemTap,
                    ),
            ),
          ],
        ),
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
    final palette = MentorXThemeColorPalette.light;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: palette.backgroundSecondary, width: 2),
        ),
      ),
      child: Row(
        children: CourseDetailTab.values.map((tab) {
          final isSelected = tab == selectedTab;
          final label = switch (tab) {
            CourseDetailTab.description => context.t.course.tabs.description,
            CourseDetailTab.sessions => context.t.course.tabs.sessions,
          };

          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? palette.brandPrimary
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                    color: isSelected
                        ? palette.brandPrimary
                        : palette.textSecondary,
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
    final palette = MentorXThemeColorPalette.light;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.course.detail.aboutCourse,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
              ),
            ),
            const Gap(16),
            if (course.subtitle != null)
              Text(
                course.subtitle!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: palette.textSecondary,
                  height: 1.6,
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
                  palette: palette,
                ),
                _InfoChip(
                  icon: Icons.timer_rounded,
                  label:
                      '${course.totalDurationMinutes} ${context.t.course.detail.minutes}',
                  palette: palette,
                ),
                _InfoChip(
                  icon: Icons.people_rounded,
                  label:
                      '${course.enrolledCount} ${context.t.course.detail.students}',
                  palette: palette,
                ),
                _InfoChip(
                  icon: Icons.library_books_rounded,
                  label:
                      '${course.totalSessions} ${context.t.course.detail.sessions}',
                  palette: palette,
                ),
                if (course.pointsReward > 0)
                  _InfoChip(
                    icon: Icons.stars_rounded,
                    label: '${course.pointsReward} Points Reward',
                    palette: palette,
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
  final MentorXThemeColorPalette palette;
  final bool isHighlight;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.palette,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlight
            ? palette.brandPrimary.withValues(alpha: 0.1)
            : palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isHighlight
              ? palette.brandPrimary.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isHighlight ? palette.brandPrimary : palette.textTertiary,
          ),
          const Gap(8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: isHighlight ? palette.brandPrimary : palette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

final class _SessionsTab extends StatelessWidget {
  final List<SessionEntity> sessions;
  final Map<String, List<SessionItemEntity>> sessionItems;
  final bool isLoading;
  final ValueChanged<SessionItemEntity> onItemTap;

  const _SessionsTab({
    required this.sessions,
    required this.sessionItems,
    required this.isLoading,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (sessions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Text(
            context.t.course.errors.failedToLoadSessions,
            style: TextStyle(
              color: MentorXThemeColorPalette.light.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sessions.length,
      separatorBuilder: (_, _) => const Gap(8),
      itemBuilder: (context, index) {
        final session = sessions[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: SessionExpansionTile(
            session: session,
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
    final palette = MentorXThemeColorPalette.light;

    return Container(
      decoration: BoxDecoration(
        color: palette.backgroundPrimary.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Row(
              children: [
                if (!isEnrolled)
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (course.isFree)
                          Text(
                            context.t.course.detail.free,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: palette.statusSuccess,
                            ),
                          )
                        else ...[
                          Text(
                            '${course.price.toInt()} ${context.t.core.currency}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: palette.textPrimary,
                            ),
                          ),
                          if (course.oldPrice != null)
                            Text(
                              '${course.oldPrice!.toInt()} ${context.t.core.currency}',
                              style: TextStyle(
                                fontSize: 13,
                                color: palette.textTertiary,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR PROGRESS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: palette.textTertiary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '${(enrollment?.progressPercent ?? 0).toInt()}% Complete',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: palette.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Gap(24),
                Expanded(
                  flex: isEnrolled ? 1 : 2,
                  child: _buildActionButton(context, palette),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    MentorXThemeColorPalette palette,
  ) {
    if (isEnrolled) {
      final status = enrollment!.status;
      return SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: status == EnrollmentStatus.active ? () {} : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: status == EnrollmentStatus.active
                ? palette.brandSecondary
                : status == EnrollmentStatus.completed
                ? palette.statusSuccess
                : palette.statusDanger,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            status == EnrollmentStatus.active
                ? context.t.course.detail.continueStudying
                : status == EnrollmentStatus.completed
                ? context.t.course.detail.courseCompleted
                : context.t.course.detail.courseExpired,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
        ),
      );
    }

    return Container(
      height: 56,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnrolling ? null : onEnrollTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.brandPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: isEnrolling
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : Text(
                context.t.course.detail.enrollNow,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
