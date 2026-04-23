import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
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
      )..add(AttendanceStarted(childId)),
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state.status == AttendanceBlocStatus.loading) {
            return const AppDashboardScaffold(
              title: 'Attendance',
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == AttendanceBlocStatus.failure) {
            return AppDashboardScaffold(
              title: 'Attendance',
              body: AppErrorView(
                message: state.errorMessage ?? 'Failed to load attendance data.',
                onRetry: () {
                  context.read<AttendanceBloc>().add(AttendanceStarted(childId));
                },
              ),
            );
          }

          if (state.attendanceRecords.isEmpty) {
            return AppDashboardScaffold(
              title: 'Attendance',
              body: const AppEmptyView(
                icon: Icons.calendar_month_outlined,
                title: 'No Records',
                message: 'No attendance records found for this child.',
              ),
            );
          }

          return AppDashboardScaffold(
            title: 'Attendance',
            onRefresh: () async {
              context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
            },
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
                },
              ),
            ],
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.attendanceSummary != null) ...[
                  AttendanceRateCard(
                    rate: state.attendanceSummary!.attendanceRate,
                    stats: [
                      AttendanceSummaryStat(
                        label: 'Present',
                        value: state.attendanceSummary!.present.toString(),
                        color: context.statusSuccessColor,
                      ),
                      AttendanceSummaryStat(
                        label: 'Absent',
                        value: state.attendanceSummary!.absent.toString(),
                        color: context.statusDangerColor,
                      ),
                      AttendanceSummaryStat(
                        label: 'Late',
                        value: state.attendanceSummary!.late.toString(),
                        color: context.statusWarningColor,
                      ),
                      AttendanceSummaryStat(
                        label: 'Excused',
                        value: state.attendanceSummary!.excused.toString(),
                        color: context.brandPrimaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
                const AppSectionHeader(title: 'History'),
                const SizedBox(height: 16),
                ...state.attendanceRecords.map(
                  (record) => GenericListTile(
                    title: record.courseName ?? 'Regular Session',
                    subtitle: '${record.sessionTitle ?? ''} • ${record.date.toString().split(' ').first}',
                    trailing: _AttendanceBadge(status: record.status),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AttendanceBadge extends StatelessWidget {
  final AttendanceStatus status;

  const _AttendanceBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      AttendanceStatus.present => StatusBadge(label: 'Present', color: context.statusSuccessColor),
      AttendanceStatus.absent => StatusBadge(label: 'Absent', color: context.statusDangerColor),
      AttendanceStatus.late => StatusBadge(label: 'Late', color: context.statusWarningColor),
      AttendanceStatus.excused => StatusBadge(label: 'Excused', color: context.brandPrimaryColor),
    };
  }
}
