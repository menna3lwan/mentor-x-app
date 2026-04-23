import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'achievement_icon.dart';

class RecentAchievementsCard extends StatelessWidget {
  const RecentAchievementsCard({
    super.key,
    required this.recentAchievements,
  });

  final List<({String title, String date, int iconCodePoint})>
  recentAchievements;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
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
          if (recentAchievements.isEmpty)
            const Text('No recent achievements yet.')
          else ...[
            for (final achievement in recentAchievements) ...[
              AchievementIcon(
                color: context.brandPrimaryColor,
                title: achievement.title,
                subtitle: achievement.date,
                iconCodePoint: achievement.iconCodePoint,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
