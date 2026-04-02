import 'package:flutter/material.dart';

class SubjectPerformanceCard extends StatelessWidget {
  const SubjectPerformanceCard({
    super.key,
    required this.subjectPerformance,
  });

  final List<({String subject, double performance})> subjectPerformance;

  @override
  Widget build(BuildContext context) {
    final averagePerformance = subjectPerformance.isEmpty
        ? 0.0
        : subjectPerformance
                  .map((item) => item.performance)
                  .reduce((a, b) => a + b) /
              subjectPerformance.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subject Performance",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (subjectPerformance.isEmpty) ...[
            const Text('No subject performance data available.'),
          ] else ...[
            for (final item in subjectPerformance) ...[
              Text(item.subject),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: item.performance.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                color: Colors.black,
                minHeight: 8,
              ),
              const SizedBox(height: 10),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Average\n${(averagePerformance * 100).toStringAsFixed(0)}%',
                ),
                const Text('Assignments\n9/10'),
                const Text('Participation\nExcellent'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
