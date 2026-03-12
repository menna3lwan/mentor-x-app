import 'package:flutter/material.dart';

class SubjectPerformanceCard extends StatelessWidget {
  const SubjectPerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
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

          const Text("Mathematics"),
          const SizedBox(height: 6),

          LinearProgressIndicator(
            value: 0.85,
            backgroundColor: Colors.grey[300],
            color: Colors.black,
            minHeight: 8,
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quiz Average\n85%"),
              Text("Assignments\n9/10"),
              Text("Participation\nExcellent"),
            ],
          ),
        ],
      ),
    );
  }
}
