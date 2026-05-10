import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'analytics_section_card.dart';

final class AchievementsSection extends StatelessWidget {
  final List<AchievementEntity> achievements;

  const AchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return AnalyticsSectionCard(
      title: 'Achievements',
      child: SizedBox(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: achievements.length,
          separatorBuilder: (context, index) => const Gap(24),
          itemBuilder: (context, index) {
            final achievement = achievements[index];
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: context.backgroundSecondaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: achievement.isUnlocked
                              ? context.brandPrimaryColor.withValues(alpha: 0.5)
                              : context.borderPrimaryColor.withValues(
                                  alpha: 0.1,
                                ),
                          width: 2,
                        ),
                      ),
                      child: Opacity(
                        opacity: achievement.isUnlocked ? 1.0 : 0.3,
                        child: Center(
                          child: Icon(
                            _getAchievementIcon(achievement.id),
                            color: achievement.isUnlocked
                                ? Colors.amber
                                : context.textTertiaryColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    if (!achievement.isUnlocked)
                      const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white54,
                        size: 20,
                      ),
                  ],
                ),
                const Gap(12),
                SizedBox(
                  width: 80,
                  child: Text(
                    achievement.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: achievement.isUnlocked
                          ? context.textPrimaryColor
                          : context.textTertiaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IconData _getAchievementIcon(String id) {
    switch (id) {
      case '1':
        return Icons.auto_awesome_rounded;
      case '2':
        return Icons.menu_book_rounded;
      case '3':
        return Icons.speed_rounded;
      case '4':
        return Icons.lightbulb_outline_rounded;
      default:
        return Icons.emoji_events_rounded;
    }
  }
}
