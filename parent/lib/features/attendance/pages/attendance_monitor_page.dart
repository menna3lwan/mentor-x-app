import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/attendance_bloc.dart';

final class AttendanceMonitorPage extends StatelessWidget {
  final AttendanceBlocStatus status;
  final String? errorMessage;
  final List<AttendanceRecordEntity> attendanceRecords;
  final AttendanceSummaryEntity? attendanceSummary;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;

  const AttendanceMonitorPage({
    super.key,
    required this.status,
    required this.errorMessage,
    required this.attendanceRecords,
    required this.attendanceSummary,
    required this.onRefresh,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Attendance Monitor',
      onRefresh: () async => onRefresh(),
      actions: [
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (status == AttendanceBlocStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == AttendanceBlocStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? 'Failed to load attendance data',
        onRetry: onRetry,
      );
    }

    if (attendanceRecords.isEmpty) {
      return AppEmptyView(
        title: 'No Records',
        message: 'No attendance records found for this student.',
        icon: Icons.calendar_today_rounded,
        onAction: onRefresh,
        actionLabel: 'Refresh',
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (attendanceSummary != null) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: AttendanceRateCard(
              rate: attendanceSummary!.attendanceRate,
              stats: [
                AttendanceSummaryStat(
                  label: 'Present',
                  value: attendanceSummary!.present.toString(),
                  color: context.statusSuccessColor,
                ),
                AttendanceSummaryStat(
                  label: 'Absent',
                  value: attendanceSummary!.absent.toString(),
                  color: context.statusDangerColor,
                ),
                AttendanceSummaryStat(
                  label: 'Late',
                  value: attendanceSummary!.late.toString(),
                  color: context.statusWarningColor,
                ),
                AttendanceSummaryStat(
                  label: 'Excused',
                  value: attendanceSummary!.excused.toString(),
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
