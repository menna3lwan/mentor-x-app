import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:parent/core/core.dart';
import '../bloc/attendance_bloc.dart';

class AttendanceMonitorPage extends StatelessWidget {
  final String childId;

  const AttendanceMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(
        repository: context.read<ParentAttendanceRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(AttendanceStarted(childId)),
      child: Builder(
        builder: (context) {
          return AppDashboardScaffold(
            title: 'Attendance Monitor',
            onRefresh: () async {
              context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final status = context.select<AttendanceBloc, AttendanceBlocStatus>(
      (bloc) => bloc.state.status,
    );
    final errorMessage = context.select<AttendanceBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );

    if (status == AttendanceBlocStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == AttendanceBlocStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? 'Failed to load attendance data',
        onRetry: () => context.read<AttendanceBloc>().add(AttendanceStarted(childId)),
      );
    }

    final attendanceRecords = context.select<AttendanceBloc, List<AttendanceRecordEntity>>(
      (bloc) => bloc.state.attendanceRecords,
    );

    if (attendanceRecords.isEmpty) {
      return AppEmptyView(
        title: 'No Records',
        message: 'No attendance records found for this student.',
        icon: Icons.calendar_today_rounded,
        onAction: () => context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId)),
        actionLabel: 'Refresh',
      );
    }

    final attendanceSummary = context.select<AttendanceBloc, AttendanceSummaryEntity?>(
      (bloc) => bloc.state.attendanceSummary,
    );

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (attendanceSummary != null) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AttendanceRateCard(
              rate: attendanceSummary.attendanceRate,
              stats: [
                AttendanceSummaryStat(
                  label: 'Present',
                  value: attendanceSummary.present.toString(),
                  color: context.statusSuccessColor,
                ),
                AttendanceSummaryStat(
                  label: 'Absent',
                  value: attendanceSummary.absent.toString(),
                  color: context.statusDangerColor,
                ),
                AttendanceSummaryStat(
                  label: 'Late',
                  value: attendanceSummary.late.toString(),
                  color: context.statusWarningColor,
                ),
                AttendanceSummaryStat(
                  label: 'Excused',
                  value: attendanceSummary.excused.toString(),
                  color: context.brandPrimaryColor,
                ),
              ],
            ),
          ),
          const Gap(32),
        ],
        
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: const AppSectionHeader(title: 'Attendance Log'),
        ),
        const Gap(16),
        
        ...attendanceRecords.asMap().entries.map(
          (entry) => FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * entry.key),
            child: _AttendanceRecordCard(record: entry.value),
          ),
        ),
        
        const Gap(40),
      ],
    );
  }
}

// Removed _BuildHeader, _BuildSummaryCard, and _StatMiniItem in favor of standardized components

class _AttendanceRecordCard extends StatelessWidget {
  final AttendanceRecordEntity record;

  const _AttendanceRecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context, record.status);
    final statusLabel = record.status.name.toUpperCase();

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
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.event_available_rounded, color: statusColor, size: 24),
        ),
        title: Text(
          record.courseName ?? 'Regular Session',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${record.sessionTitle ?? "General Academic"} • ${record.date.toString().split(" ").first}',
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: StatusBadge(
          label: statusLabel,
          color: statusColor,
          isSmall: true,
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.present => context.statusSuccessColor,
      AttendanceStatus.absent => context.statusDangerColor,
      AttendanceStatus.late => context.statusWarningColor,
      AttendanceStatus.excused => context.brandPrimaryColor,
    };
  }
}
