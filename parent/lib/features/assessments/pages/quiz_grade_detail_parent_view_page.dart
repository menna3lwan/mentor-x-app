import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
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
        QuizAttemptEntity? attempt;
        for (final item in state.assessments) {
          if (item.id == assessmentId) {
            attempt = item;
            break;
          }
        }
        if (attempt == null) {
          return const Scaffold(body: Center(child: Text('Quiz attempt not found.')));
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Quiz Grade Detail')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quiz ID: ${attempt.quizId}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Score: ${attempt.score}/${attempt.totalMarks}'),
                Text(
                  'Percentage: ${attempt.percentage.toStringAsFixed(1)}%',
                ),
                Text('Status: ${attempt.status.name.toUpperCase()}'),
                const SizedBox(height: 18),
                const Text(
                  'Question Breakdown',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: 6, // Mocking breakdown for now
                    itemBuilder: (context, index) => ListTile(
                      dense: true,
                      leading: Icon(
                        index.isEven ? Icons.check_circle : Icons.cancel,
                        color: index.isEven ? Colors.green : Colors.red,
                      ),
                      title: Text('Question ${index + 1}'),
                      subtitle: Text(index.isEven ? 'Correct' : 'Incorrect'),
                    ),
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
