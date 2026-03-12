import 'package:flutter/material.dart';
import 'package:mentorx/ui/home/widgets/recent_achievement_card.dart';
import 'package:mentorx/ui/home/widgets/state_card.dart';
import 'package:mentorx/ui/home/widgets/student_data_card.dart';
import 'package:mentorx/ui/home/widgets/subject_performance_card.dart';
import 'package:mentorx/ui/home/widgets/weekly_learning_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "parentHome";

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
              /// Title
              StudentDataCard(),

              const SizedBox(height: 20),

              /// Stats
              Row(
                children: [
                  Expanded(
                    child: StateCard(
                      title: "This Week",
                      value: "20",
                      subtitle: "Lessons Completed",
                      color: Colors.blue.shade100,
                      icon: Icons.check_circle,
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: StateCard(
                      title: "Study Time",
                      value: "5.2h",
                      subtitle: "+1.2h from last week",
                      color: Colors.green.shade100,
                      icon: Icons.access_time,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              WeeklyLearningCard(),

              const SizedBox(height: 20),

              SubjectPerformanceCard(),
              const SizedBox(height: 20),

              RecentAchievementsCard(),
              const SizedBox(height: 20),

              /// AI Insights
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "AI Learning Insights",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Alex shows strong improvement in algebra. Consider introducing geometry concepts next.",
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("View Detailed Report"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
