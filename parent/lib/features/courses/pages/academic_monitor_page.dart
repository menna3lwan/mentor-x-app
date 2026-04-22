import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/courses_bloc.dart';

class AcademicMonitorPage extends StatelessWidget {
  final String childId;

  const AcademicMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesBloc(
        courseRepository: context.read<ParentCourseRepository>(),
        gradeRepository: context.read<ParentGradeRepository>(),
      )..add(CoursesStarted(childId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Academic Status'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<CoursesBloc>().add(CoursesRefreshRequested(childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, state) {
            if (state.status == CoursesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == CoursesStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load courses: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CoursesBloc>().add(CoursesStarted(childId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.courses.isEmpty) {
              return const Center(child: Text('No enrolled courses found.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CoursesBloc>().add(CoursesRefreshRequested(childId));
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (state.gradeSummary != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Overall Average',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '${state.gradeSummary!.overallAverage.toStringAsFixed(1)}%',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: state.gradeSummary!.distribution.entries
                                  .map((entry) => Column(
                                        children: [
                                          Text(
                                            entry.key,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(entry.value.toString()),
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    'Enrolled Courses',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...state.courses.map((course) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(course.title),
                          subtitle: Text('Sessions: ${course.totalSessions}'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Navigation to progress detail
                          },
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
