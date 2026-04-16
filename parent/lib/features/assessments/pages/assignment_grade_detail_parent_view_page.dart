import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';
import '../bloc/assessments_bloc.dart';

final class AssignmentGradeDetailParentViewPage extends StatelessWidget {
  final String assessmentId;

  const AssignmentGradeDetailParentViewPage({
    super.key,
    required this.assessmentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentsBloc, AssessmentsState>(
      builder: (context, state) {
        ParentAssessmentRecord? assessment;
        for (final item in state.assessments) {
          if (item.id == assessmentId) {
            assessment = item;
            break;
          }
        }
        if (assessment == null) {
          return const Scaffold(
            body: Center(child: Text('Assignment not found.')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Assignment Grade Detail')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  assessment.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Course: ${assessment.courseName}'),
                Text('Status: ${assessment.status}'),
                Text('Score: ${assessment.score}/${assessment.totalScore}'),
                Text(
                  'Percentage: ${assessment.percentage.toStringAsFixed(1)}%',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Teacher Feedback',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Great effort. Keep improving your solution explanation and structure.',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Submitted Files',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const ListTile(
                  leading: Icon(Icons.attach_file),
                  title: Text('assignment_solution.pdf'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
