import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';
import '../bloc/assessments_bloc.dart';

final class QuizGradeDetailParentViewPage extends StatelessWidget {
  final String assessmentId;

  const QuizGradeDetailParentViewPage({
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
          return const Scaffold(body: Center(child: Text('Quiz not found.')));
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Quiz Grade Detail')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('Score: ${assessment.score}/${assessment.totalScore}'),
                Text(
                  'Percentage: ${assessment.percentage.toStringAsFixed(1)}%',
                ),
                Text('Attempts: ${assessment.attempts}'),
                const SizedBox(height: 18),
                const Text(
                  'Question Breakdown',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  6,
                  (index) => ListTile(
                    dense: true,
                    leading: Icon(
                      index.isEven ? Icons.check_circle : Icons.cancel,
                      color: index.isEven ? Colors.green : Colors.red,
                    ),
                    title: Text('Question ${index + 1}'),
                    subtitle: Text(index.isEven ? 'Correct' : 'Incorrect'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
