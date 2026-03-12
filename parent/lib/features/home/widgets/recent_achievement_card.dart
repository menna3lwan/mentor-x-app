import 'package:flutter/material.dart';
import 'package:mentorx/ui/home/widgets/achievement_icon.dart';

class RecentAchievementsCard extends StatelessWidget {
  const RecentAchievementsCard({super.key});

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
            "Recent Achievements",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          AchievementIcon(
            color: Colors.orange,
            title: "Math Master Badge",
            subtitle: "Completed 10 algebra lessons",
          ),
          AchievementIcon(
            color: Colors.blue,
            title: "Perfect Quiz Score",
            subtitle: "100% on Quadratic Equations",
          ),
        ],
      ),
    );
  }
}
