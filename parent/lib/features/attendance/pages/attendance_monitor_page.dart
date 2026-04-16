import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/attendance_bloc.dart';

final class AttendanceMonitorPage extends StatelessWidget {
  const AttendanceMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final records = state.records;
        final total = records.length;
        final present = records
            .where((item) => item.status == 'present')
            .length;
        final late = records.where((item) => item.status == 'late').length;
        final absent = records.where((item) => item.status == 'absent').length;
        final percent = total == 0 ? 0 : ((present + late) / total) * 100;

        return Scaffold(
          appBar: AppBar(title: const Text('Attendance Monitor')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Attendance ${percent.toStringAsFixed(1)}%\nTotal $total • Present $present • Late $late • Absent $absent',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: records.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final record = records[index];
                          return ListTile(
                            leading: Icon(
                              switch (record.status) {
                                'present' => Icons.check_circle,
                                'late' => Icons.watch_later,
                                'absent' => Icons.cancel,
                                _ => Icons.info,
                              },
                            ),
                            title: Text(record.sessionName),
                            subtitle: Text(
                              '${record.centerName} • ${DateFormat('dd MMM').format(record.date)}\n${record.startTime}-${record.endTime}',
                            ),
                            isThreeLine: true,
                            trailing: Text(record.status.toUpperCase()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
