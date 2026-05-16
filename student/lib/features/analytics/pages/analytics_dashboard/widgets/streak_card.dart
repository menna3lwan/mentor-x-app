import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'analytics_section_card.dart';

final class StreakCard extends StatelessWidget {
  final StreakEntity streak;

  const StreakCard({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    final progress = streak.longestStreak > 0
        ? streak.currentStreak / streak.longestStreak
        : 0.0;
    final t = context.t.analytics;

    return AnalyticsSectionCard(
      title: t.studyConsistency,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.orange.withValues(alpha: 0.25),
                  Colors.orange.withValues(alpha: 0.05),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: Colors.white,
                size: 44,
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${streak.currentStreak}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.daysStreak(days: streak.currentStreak.toString()),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.orange,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: context.borderPrimaryColor.withValues(
                      alpha: 0.05,
                    ),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                    minHeight: 10,
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.personalBestLabel(
                        count: streak.longestStreak.toString(),
                      ),
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (streak.currentStreak == streak.longestStreak &&
                        streak.currentStreak > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.statusSuccessColor.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          t.newRecord,
                          style: TextStyle(
                            fontSize: 9,
                            color: context.statusSuccessColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
