import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
          ? _EnrollmentBar(
              course: course!,
              enrollment: enrollment,
              isEnrolling: isEnrolling,
              isEnrolled: isEnrolled,
              onEnrollTap: onEnrollTap,
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
            Icon(Icons.error_outline, size: 48, color: palette.statusDanger),
            const SizedBox(height: 12),
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
            CourseInfoHeader(
              course: course!,
              enrollment: enrollment,
            ),
            _DetailTabBar(
              selectedTab: selectedTab,
              onTabChanged: onTabChanged,
            ),
            if (selectedTab == CourseDetailTab.description)
              _DescriptionTab(course: course!)
            else
              _SessionsTab(
                sessions: sessions,
                sessionItems: sessionItems,
                isLoading: isSessionsLoading,
                onItemTap: onSessionItemTap,
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
          bottom: BorderSide(color: palette.textTertiary, width: 0.5),
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
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? palette.brandPrimary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.t.course.detail.aboutCourse,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (course.subtitle != null)
            Text(
              course.subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
                height: 1.6,
              ),
            ),
          const SizedBox(height: 20),
          _InfoRow(
            icon: Icons.play_circle_outline,
            label: '${course.totalVideos} ${context.t.course.detail.videos}',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.access_time,
            label:
                '${context.t.course.detail.duration}: ${course.totalDurationMinutes} ${context.t.course.detail.minutes}',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.people_outline,
            label:
                '${course.enrolledCount} ${context.t.course.detail.students}',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.list_alt,
            label:
                '${course.totalSessions} ${context.t.course.detail.sessions}',
          ),
          if (course.pointsReward > 0) ...[
            const SizedBox(height: 10),
            _InfoRow(
              icon: Icons.star_outline,
              label: '${course.pointsReward} points reward',
            ),
          ],
        ],
      ),
    );
  }
}

final class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Row(
      children: [
        Icon(icon, size: 20, color: palette.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: palette.textSecondary),
        ),
      ],
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
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (sessions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            context.t.course.errors.failedToLoadSessions,
            style: TextStyle(
              color: MentorXThemeColorPalette.light.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return SessionExpansionTile(
          session: session,
          items: sessionItems[session.id] ?? const [],
          onItemTap: onItemTap,
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
        color: palette.backgroundPrimary.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
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
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: palette.statusSuccess,
                            ),
                          )
                        else ...[
                          Text(
                            '${course.price.toInt()} ${context.t.core.currency}',
                            style: TextStyle(
                              fontSize: 20,
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
                                fontWeight: FontWeight.w500,
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
                          'Your Progress',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: palette.textSecondary,
                          ),
                        ),
                        Text(
                          '${(enrollment?.progressPercent ?? 0).toInt()}% Complete',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: palette.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 20),
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
        height: 54,
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(
            status == EnrollmentStatus.active
                ? context.t.course.detail.continueStudying
                : status == EnrollmentStatus.completed
                    ? context.t.course.detail.courseCompleted
                    : context.t.course.detail.courseExpired,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
        ),
      );
    }

    return Container(
      height: 54,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnrolling ? null : onEnrollTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.brandPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isEnrolling
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
              )
            : Text(
                context.t.course.detail.enrollNow,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
      ),
    );
  }
}
