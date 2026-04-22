import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state.status == AttendanceBlocStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == AttendanceBlocStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load attendance: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AttendanceBloc>().add(AttendanceStarted(childId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.attendanceRecords.isEmpty) {
              return const Center(child: Text('No attendance records found.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<AttendanceBloc>().add(AttendanceRefreshRequested(childId));
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.attendanceSummary != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Attendance Rate',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                    Text(
                                      '${(state.attendanceSummary!.attendanceRate * 100).toStringAsFixed(0)}%',
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                CircularProgressIndicator(
                                  value: state.attendanceSummary!.attendanceRate,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.grey[200],
                                ),
                              ],
                            ),
                            const Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _SummaryStat(
                                  label: 'Present',
                                  value: state.attendanceSummary!.present.toString(),
                                  color: Colors.green,
                                ),
                                _SummaryStat(
                                  label: 'Absent',
                                  value: state.attendanceSummary!.absent.toString(),
                                  color: Colors.red,
                                ),
                                _SummaryStat(
                                  label: 'Late',
                                  value: state.attendanceSummary!.late.toString(),
                                  color: Colors.orange,
                                ),
                                _SummaryStat(
                                  label: 'Excused',
                                  value: state.attendanceSummary!.excused.toString(),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    'History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...state.attendanceRecords.map((record) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(record.courseName ?? 'Regular Session'),
                          subtitle: Text(
                            '${record.sessionTitle ?? ''} • ${record.date.toString().split(' ').first}',
                          ),
                          trailing: _AttendanceBadge(status: record.status),
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AttendanceBadge extends StatelessWidget {
  final AttendanceStatus status;

  const _AttendanceBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case AttendanceStatus.present:
        color = Colors.green;
        label = 'Present';
      case AttendanceStatus.absent:
        color = Colors.red;
        label = 'Absent';
      case AttendanceStatus.late:
        color = Colors.orange;
        label = 'Late';
      case AttendanceStatus.excused:
        color = Colors.blue;
        label = 'Excused';
    }

    return Chip(
      padding: EdgeInsets.zero,
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      backgroundColor: color,
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
