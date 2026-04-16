import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../portal_data/portal_data.dart';
import '../bloc/courses_bloc.dart';

final class CourseProgressDetailPage extends StatelessWidget {
  final String courseId;

  const CourseProgressDetailPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        ParentCourseProgress? course;
        for (final item in state.courses) {
          if (item.id == courseId) {
            course = item;
            break;
          }
        }
        if (course == null) {
          return const Scaffold(
            body: Center(child: Text('Course not found.')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(course.title)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Teacher: ${course.teacherName}'),
                      Text('Progress: ${course.progressPercent}%'),
                      Text(
                        'Sessions: ${course.completedSessions}/${course.totalSessions}',
                      ),
                      Text(
                        'Time spent: ${course.timeSpentHours.toStringAsFixed(1)}h',
                      ),
                      Text(
                        'Last activity: ${DateFormat('dd MMM yyyy').format(course.lastAccessedAt)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Learning Activity',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              ...List.generate(
                6,
                (index) => ListTile(
                  leading: const Icon(Icons.play_circle_outline),
                  title: Text('Session item ${index + 1}'),
                  subtitle: Text(index.isEven ? 'Completed' : 'In progress'),
                  trailing: Text('${(index + 1) * 8} min'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
