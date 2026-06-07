import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';
import '../bloc/attendance_bloc.dart';
import 'attendance_monitor_page.dart';

final class AttendanceMonitorPageWrapper extends StatelessWidget {
  final String childId;

  const AttendanceMonitorPageWrapper({
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
          final status = context.select<AttendanceBloc, AttendanceBlocStatus>(
            (bloc) => bloc.state.status,
          );
          final errorMessage = context.select<AttendanceBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );
          final attendanceRecords = context.select<AttendanceBloc, List<AttendanceRecordEntity>>(
            (bloc) => bloc.state.attendanceRecords,
          );
          final attendanceSummary = context.select<AttendanceBloc, AttendanceSummaryEntity?>(
            (bloc) => bloc.state.attendanceSummary,
          );

          return AttendanceMonitorPage(
            status: status,
            errorMessage: errorMessage,
            attendanceRecords: attendanceRecords,
            attendanceSummary: attendanceSummary,
            onRefresh: () {
              final bloc = context.read<AttendanceBloc>();
              bloc.add(AttendanceRefreshRequested(childId));
            },
            onRetry: () {
              final bloc = context.read<AttendanceBloc>();
              bloc.add(AttendanceStarted(childId));
            },
          );
        },
      ),
    );
  }
}
