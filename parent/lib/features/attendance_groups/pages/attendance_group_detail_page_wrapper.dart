import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/attendance_group_detail_bloc.dart';
import 'group_schedule_formatter.dart';

/// Detail page for a single attendance group — schedule, attendance ratio,
/// recent sessions.
class AttendanceGroupDetailPageWrapper extends StatelessWidget {
  final String childId;
  final String groupId;
  const AttendanceGroupDetailPageWrapper({
    super.key,
    required this.childId,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceGroupDetailBloc(
            repository: context.read<ParentAttendanceGroupsRepository>(),
          )..add(
            AttendanceGroupDetailStarted(
              childId: childId,
              groupId: groupId,
            ),
          ),
      child: _AttendanceGroupDetailView(childId: childId),
    );
  }
}

class _AttendanceGroupDetailView extends StatelessWidget {
  final String childId;
  const _AttendanceGroupDetailView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<
      AttendanceGroupDetailBloc,
      AttendanceGroupDetailPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case AttendanceGroupDetailFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case AttendanceGroupDetailNotFoundPresentationEvent():
            MentorXUI.showToast(
              message: t.attendanceTracking.groupNotFoundHint,
              isError: true,
            );
            if (context.canPop()) {
              context.pop();
            } else {
              AttendanceGroupsRoute(childId: childId).go(context);
            }
          case AttendanceGroupDetailUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: BlocBuilder<AttendanceGroupDetailBloc, AttendanceGroupDetailState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            appBar: AppBar(
              backgroundColor: context.backgroundSecondaryColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    AttendanceGroupsRoute(childId: childId).go(context);
                  }
                },
              ),
              title: Text(
                state.detail?.group.name.isNotEmpty == true
                    ? state.detail!.group.name
                    : t.attendanceTracking.groupDetailTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: context.brandPrimaryColor,
                ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async => context
                  .read<AttendanceGroupDetailBloc>()
                  .add(const AttendanceGroupDetailRefreshRequested()),
              child: _bodyFor(context, state, t),
            ),
          );
        },
      ),
    );
  }

  Widget _bodyFor(
    BuildContext context,
    AttendanceGroupDetailState state,
    TranslationsParentEn t,
  ) {
    if (state.status.isInitial || state.status.isLoading) {
      return ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          MentorXSkeleton(
            width: double.infinity,
            height: 160,
            borderRadius: 24,
          ),
          SizedBox(height: 16),
          MentorXSkeleton(
            width: double.infinity,
            height: 100,
            borderRadius: 24,
          ),
          SizedBox(height: 16),
          MentorXSkeleton(
            width: double.infinity,
            height: 200,
            borderRadius: 24,
          ),
        ],
      );
    }
    if (state.status.isFailure) {
      return AppErrorView(
        message: state.errorMessage ?? t.attendanceTracking.groupFailureTitle,
        onRetry: () => context.read<AttendanceGroupDetailBloc>().add(
          const AttendanceGroupDetailRefreshRequested(),
        ),
      );
    }
    final detail = state.detail;
    if (detail == null || detail.group.id.isEmpty) {
      return AppEmptyView(
        title: t.attendanceTracking.groupNotFoundTitle,
        message: t.attendanceTracking.groupNotFoundHint,
        icon: Icons.group_remove_outlined,
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(20),
      children: [
        _HeroCard(detail: detail),
        const Gap(20),
        _ScheduleCard(detail: detail),
        const Gap(20),
        _AttendanceCard(detail: detail),
        if (detail.recentSessions.isNotEmpty) ...[
          const Gap(20),
          _RecentSessionsCard(detail: detail),
        ],
        if ((detail.description != null && detail.description!.isNotEmpty) ||
            (detail.location != null && detail.location!.isNotEmpty)) ...[
          const Gap(20),
          _MetadataCard(detail: detail),
        ],
        const Gap(40),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final ParentAttendanceGroupDetailEntity detail;
  const _HeroCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.brandPrimaryColor,
            context.brandPrimaryColor.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.group.name,
            style: TextStyle(
              color: context.textForegroundColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (detail.group.courseName != null) ...[
            const Gap(4),
            Text(
              '${t.attendanceTracking.groupCourseLabel}: ${detail.group.courseName}',
              style: TextStyle(
                color: context.textForegroundColor.withValues(alpha: 0.85),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          if (detail.group.teacherName != null) ...[
            const Gap(2),
            Text(
              '${t.attendanceTracking.groupTeacherLabel}: ${detail.group.teacherName}',
              style: TextStyle(
                color: context.textForegroundColor.withValues(alpha: 0.85),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const Gap(16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroChip(
                icon: Icons.people_outline_rounded,
                label: t.attendanceTracking.groupEnrolledLabel(
                  count: detail.group.enrolledCount,
                ),
              ),
              if (detail.startDate != null)
                _HeroChip(
                  icon: Icons.event_available_outlined,
                  label: t.attendanceTracking.groupStartDateLabel(
                    date: DateFormat.yMMMd().format(detail.startDate!),
                  ),
                ),
              if (detail.endDate != null)
                _HeroChip(
                  icon: Icons.event_busy_outlined,
                  label: t.attendanceTracking.groupEndDateLabel(
                    date: DateFormat.yMMMd().format(detail.endDate!),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: context.textForegroundColor, size: 14),
          const Gap(6),
          Text(
            label,
            style: TextStyle(
              color: context.textForegroundColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.textTertiaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const Gap(14),
          child,
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final ParentAttendanceGroupDetailEntity detail;
  const _ScheduleCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    if (detail.group.schedule.isEmpty) {
      return _Card(
        title: t.attendanceTracking.groupScheduleTitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            t.attendanceTracking.groupNoSchedule,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return _Card(
      title: t.attendanceTracking.groupScheduleTitle,
      child: Column(
        children: [
          for (var i = 0; i < detail.group.schedule.length; i++) ...[
            if (i > 0) const Gap(10),
            _ScheduleRow(entry: detail.group.schedule[i]),
          ],
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final ParentGroupScheduleEntry entry;
  const _ScheduleRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return Row(
      children: [
        Container(
          width: 56,
          height: 36,
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            GroupScheduleFormatter.dayName(entry.dayOfWeek, t),
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            '${entry.startTime} — ${entry.endTime}',
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        if (entry.room != null && entry.room!.isNotEmpty)
          Text(
            t.attendanceTracking.groupSessionRoomLabel(room: entry.room!),
            style: TextStyle(
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final ParentAttendanceGroupDetailEntity detail;
  const _AttendanceCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final percent = (detail.attendanceRatio * 100).round();
    return _Card(
      title: t.attendanceTracking.groupAttendanceTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.attendanceTracking.groupAttendanceRatioLabel,
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$percent%',
                style: TextStyle(
                  color: context.brandPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Gap(8),
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: detail.attendanceRatio,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const Gap(14),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  label: t.attendanceTracking.groupAttendedSessions(
                    count: detail.attendedSessions,
                  ),
                  color: context.statusSuccessColor,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
              const Gap(8),
              Expanded(
                child: _StatBox(
                  label: t.attendanceTracking.groupMissedSessions(
                    count: detail.missedSessions,
                  ),
                  color: context.statusDangerColor,
                  icon: Icons.cancel_outlined,
                ),
              ),
              const Gap(8),
              Expanded(
                child: _StatBox(
                  label: t.attendanceTracking.groupLateSessions(
                    count: detail.lateSessions,
                  ),
                  color: context.statusWarningColor,
                  icon: Icons.access_time_rounded,
                ),
              ),
            ],
          ),
          const Gap(10),
          Text(
            t.attendanceTracking.groupTotalSessions(
              count: detail.totalSessions,
            ),
            style: TextStyle(
              color: context.textTertiaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  const _StatBox({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentSessionsCard extends StatelessWidget {
  final ParentAttendanceGroupDetailEntity detail;
  const _RecentSessionsCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return _Card(
      title: t.attendanceTracking.groupRecentSessionsTitle,
      child: Column(
        children: [
          for (var i = 0; i < detail.recentSessions.length; i++) ...[
            if (i > 0)
              Divider(
                height: 18,
                color: context.textTertiaryColor.withValues(alpha: 0.08),
              ),
            _SessionRow(session: detail.recentSessions[i]),
          ],
        ],
      ),
    );
  }
}

class _SessionRow extends StatelessWidget {
  final ParentGroupSessionEntity session;
  const _SessionRow({required this.session});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final color = switch (session.status) {
      AttendanceStatus.present => context.statusSuccessColor,
      AttendanceStatus.absent => context.statusDangerColor,
      AttendanceStatus.late => context.statusWarningColor,
      AttendanceStatus.excused => context.brandPrimaryColor,
    };
    final statusLabel = switch (session.status) {
      AttendanceStatus.present => t.attendanceTracking.present,
      AttendanceStatus.absent => t.attendanceTracking.absent,
      AttendanceStatus.late => t.attendanceTracking.late,
      AttendanceStatus.excused => t.attendanceTracking.excused,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(_iconFor(session.status), color: color, size: 16),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.topic ?? statusLabel,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const Gap(2),
              Text(
                DateFormat.yMMMEd().format(session.date),
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
              if (session.note != null && session.note!.isNotEmpty) ...[
                const Gap(2),
                Text(
                  session.note!,
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  IconData _iconFor(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => Icons.check_rounded,
      AttendanceStatus.absent => Icons.close_rounded,
      AttendanceStatus.late => Icons.schedule_rounded,
      AttendanceStatus.excused => Icons.info_outline_rounded,
    };
  }
}

class _MetadataCard extends StatelessWidget {
  final ParentAttendanceGroupDetailEntity detail;
  const _MetadataCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return _Card(
      title: t.attendanceTracking.groupDetailTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detail.location != null && detail.location!.isNotEmpty) ...[
            _MetaRow(
              label: t.attendanceTracking.groupLocationLabel,
              value: detail.location!,
            ),
            const Gap(8),
          ],
          if (detail.description != null && detail.description!.isNotEmpty)
            _MetaRow(
              label: t.attendanceTracking.groupDescriptionLabel,
              value: detail.description!,
              multiline: true,
            ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final bool multiline;
  const _MetaRow({
    required this.label,
    required this.value,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        const Gap(2),
        Text(
          value,
          maxLines: multiline ? null : 1,
          overflow: multiline ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
