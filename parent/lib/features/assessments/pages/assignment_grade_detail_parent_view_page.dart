import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';

class AssignmentGradeDetailParentViewPage extends StatelessWidget {
  final QuizAttemptEntity attempt;

  const AssignmentGradeDetailParentViewPage({
    super.key,
    required this.attempt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Info',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _InfoRow(label: 'Quiz ID', value: attempt.quizId),
                    _InfoRow(label: 'Score', value: '${attempt.score}/${attempt.totalMarks}'),
                    _InfoRow(label: 'Percentage', value: '${attempt.percentage.toStringAsFixed(1)}%'),
                    _InfoRow(label: 'Status', value: _getStatusLabel(attempt.status)),
                    if (attempt.submittedAt != null)
                      _InfoRow(label: 'Submitted At', value: _formatDate(attempt.submittedAt!)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(QuizAttemptStatus status) {
    return status.name.toUpperCase();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
