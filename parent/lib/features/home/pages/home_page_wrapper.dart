import 'package:flutter/material.dart';
import 'home_page.dart';
import '../widgets/recent_achievement_card.dart';
import '../widgets/state_card.dart';
import '../widgets/student_data_card.dart';
import '../widgets/subject_performance_card.dart';
import '../widgets/weekly_learning_card.dart';

final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(
      studentCard: const StudentDataCard(),
      statsRow: Row(
        children: [
          Expanded(
            child: StateCard(
              title: 'This Week',
              value: '20',
              subtitle: 'Lessons Completed',
              color: Colors.blue.shade100,
              icon: Icons.check_circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StateCard(
              title: 'Study Time',
              value: '5.2h',
              subtitle: '+1.2h from last week',
              color: Colors.green.shade100,
              icon: Icons.access_time,
            ),
          ),
        ],
      ),
      weeklyLearningCard: const WeeklyLearningCard(),
      subjectPerformanceCard: const SubjectPerformanceCard(),
      recentAchievementsCard: const RecentAchievementsCard(),
      aiInsightsCard: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Learning Insights',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Alex shows strong improvement in algebra. Consider introducing geometry concepts next.',
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: const Text('View Detailed Report'),
            ),
          ],
        ),
      ),
    );
  }
}
