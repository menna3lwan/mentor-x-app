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
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isEnrolled) ...[
                  if (course.isFree)
                    Text(
                      context.t.course.detail.free,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: palette.statusSuccess,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  else ...[
                    Text(
                      '${course.price.toInt()} ${context.t.core.currency}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (course.oldPrice != null)
                      Text(
                        '${course.oldPrice!.toInt()} ${context.t.core.currency}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: palette.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ] else ...[
                  Text(
                    '${(enrollment?.progressPercent ?? 0).toInt()}%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: palette.brandPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: _buildActionButton(context, palette),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    MentorXThemeColorPalette palette,
  ) {
    if (isEnrolled) {
      final status = enrollment!.status;
      switch (status) {
        case EnrollmentStatus.active:
          return ElevatedButton(
            onPressed: null, // Could navigate to continue studying
            child: Text(context.t.course.detail.continueStudying),
          );
        case EnrollmentStatus.expired:
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: palette.statusDanger,
            ),
            child: Text(context.t.course.detail.courseExpired),
          );
        case EnrollmentStatus.completed:
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: palette.statusSuccess,
            ),
            child: Text(context.t.course.detail.courseCompleted),
          );
      }
    }

    return ElevatedButton(
      onPressed: isEnrolling ? null : onEnrollTap,
      child: isEnrolling
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(context.t.course.detail.enrollNow),
    );
  }
}
