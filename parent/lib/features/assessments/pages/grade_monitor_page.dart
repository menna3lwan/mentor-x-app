import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/assessments_bloc.dart';

class GradeMonitorPage extends StatelessWidget {
  final String childId;

  const GradeMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssessmentsBloc(
        repository: context.read<ParentGradeRepository>(),
      )..add(AssessmentsStarted(childId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Grades & Assessments'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<AssessmentsBloc, AssessmentsState>(
          builder: (context, state) {
            if (state.status == AssessmentsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == AssessmentsStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load grades: ${state.errorMessage}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AssessmentsBloc>().add(AssessmentsStarted(childId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state.assessments.isEmpty) {
              return const Center(child: Text('No assessment data available.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<AssessmentsBloc>().add(AssessmentsRefreshRequested(childId));
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
                              'Overall Grade',
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
                    'Recent Assessments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...state.assessments.map((assessment) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text('Quiz ID: ${assessment.quizId}'),
                          subtitle: Text(
                            'Score: ${assessment.score}/${assessment.totalMarks} • ${assessment.submittedAt?.toString().split(' ').first ?? 'In Progress'}',
                          ),
                          trailing: Text(
                            '${assessment.percentage.toInt()}%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: assessment.passed ? context.statusSuccessColor : context.statusDangerColor,
                            ),
                          ),
                          onTap: () {
                            // Detail navigation
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
