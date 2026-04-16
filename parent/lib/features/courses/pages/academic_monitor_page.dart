import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../bloc/courses_bloc.dart';

final class AcademicMonitorPage extends StatelessWidget {
  const AcademicMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        final courses = state.courses;
        final completed = courses
            .where((item) => item.progressPercent >= 100)
            .length;
        final overall = courses.isEmpty
            ? 0
            : courses
                      .map((item) => item.progressPercent)
                      .reduce((a, b) => a + b) /
                  courses.length;

        return Scaffold(
          appBar: AppBar(title: const Text('Academic Monitor')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CircularProgressIndicator(
                              value: overall / 100,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              '${overall.toStringAsFixed(0)}% overall\n$completed/${courses.length} courses completed',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: courses.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = courses[index];
                          return ListTile(
                            title: Text(item.title),
                            subtitle: Text(
                              '${item.teacherName} • ${item.completedSessions}/${item.totalSessions} sessions\nLast accessed ${DateFormat('dd MMM').format(item.lastAccessedAt)}',
                            ),
                            isThreeLine: true,
                            trailing: Text('${item.progressPercent}%'),
                            onTap: () {
                              CourseProgressDetailPageRoute(
                                courseId: item.id,
                              ).push(context);
                            },
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
