import 'package:flutter/material.dart';

final class HomePage extends StatelessWidget {
  final Widget studentCard;
  final Widget statsRow;
  final Widget weeklyLearningCard;
  final Widget subjectPerformanceCard;
  final Widget recentAchievementsCard;
  final Widget aiInsightsCard;

  const HomePage({
    super.key,
    required this.studentCard,
    required this.statsRow,
    required this.weeklyLearningCard,
    required this.subjectPerformanceCard,
    required this.recentAchievementsCard,
    required this.aiInsightsCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              studentCard,
              const SizedBox(height: 20),
              statsRow,
              const SizedBox(height: 20),
              weeklyLearningCard,
              const SizedBox(height: 20),
              subjectPerformanceCard,
              const SizedBox(height: 20),
              recentAchievementsCard,
              const SizedBox(height: 20),
              aiInsightsCard,
            ],
          ),
        ),
      ),
    );
  }
}
