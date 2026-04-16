import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../bloc/assessments_bloc.dart';

final class GradeMonitorPage extends StatelessWidget {
  const GradeMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentsBloc, AssessmentsState>(
      builder: (context, state) {
        final assessments = state.assessments;
        final graded = assessments
            .where((item) => item.status == 'Graded')
            .toList();
        final avg = graded.isEmpty
            ? 0.0
            : graded.map((item) => item.percentage).reduce((a, b) => a + b) /
                  graded.length;

        return Scaffold(
          appBar: AppBar(title: const Text('Grade Monitor')),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Overall average ${avg.toStringAsFixed(1)}%\n${graded.length}/${assessments.length} graded',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          for (final filter in const [
                            'all',
                            'quiz',
                            'assignment',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(filter.toUpperCase()),
                                selected: state.filter == filter,
                                onSelected: (_) {
                                  context.read<AssessmentsBloc>().add(
                                    AssessmentsFilterChanged(filter),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        itemCount: assessments.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = assessments[index];
                          return ListTile(
                            leading: Icon(
                              item.type == 'quiz'
                                  ? Icons.quiz_outlined
                                  : Icons.assignment_outlined,
                            ),
                            title: Text(item.title),
                            subtitle: Text(
                              '${item.courseName} • ${item.score}/${item.totalScore} • ${DateFormat('dd MMM').format(item.date)}',
                            ),
                            trailing: Text(
                              '${item.percentage.toStringAsFixed(0)}%',
                            ),
                            onTap: () {
                              if (item.type == 'quiz') {
                                QuizGradeDetailParentViewPageRoute(
                                  assessmentId: item.id,
                                ).push(context);
                              } else {
                                AssignmentGradeDetailParentViewPageRoute(
                                  assessmentId: item.id,
                                ).push(context);
                              }
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
