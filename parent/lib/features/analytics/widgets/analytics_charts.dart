import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Horizontal child-vs-class bar pair.
class GradeComparisonRowView extends StatelessWidget {
  final String label;
  final double childScore;
  final double classAverage;
  final String childLabel;
  final String classLabel;

  const GradeComparisonRowView({
    super.key,
    required this.label,
    required this.childScore,
    required this.classAverage,
    required this.childLabel,
    required this.classLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
            fontSize: 13,
          ),
        ),
        const Gap(8),
        _ScoreBar(
          label: childLabel,
          score: childScore,
          color: context.brandPrimaryColor,
        ),
        const Gap(6),
        _ScoreBar(
          label: classLabel,
          score: classAverage,
          color: context.brandSecondaryColor,
        ),
      ],
    );
  }
}

class _ScoreBar extends StatelessWidget {
  final String label;
  final double score;
  final Color color;

  const _ScoreBar({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (score.clamp(0, 100)) / 100.0;
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Text(
            label,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Gap(8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        SizedBox(
          width: 40,
          child: Text(
            score.toStringAsFixed(0),
            textAlign: TextAlign.end,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

/// Single per-course progress row with name, sessions count and a bar.
class CourseProgressRowView extends StatelessWidget {
  final String courseName;
  final double progressPercent;
  final String sessionsLabel;

  const CourseProgressRowView({
    super.key,
    required this.courseName,
    required this.progressPercent,
    required this.sessionsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progressPercent.clamp(0, 100)) / 100.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                courseName,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${progressPercent.toStringAsFixed(0)}%',
              style: TextStyle(
                color: context.brandPrimaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const Gap(6),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percent,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const Gap(4),
        Text(
          sessionsLabel,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Vertical bar chart of minutes-per-day. Lightweight, no external chart lib.
class ActiveHoursBarChart extends StatelessWidget {
  /// Pairs of (label, minutes).
  final List<({String label, int minutes})> points;
  final int maxMinutes;
  final String unitLabel;

  const ActiveHoursBarChart({
    super.key,
    required this.points,
    required this.maxMinutes,
    required this.unitLabel,
  });

  @override
  Widget build(BuildContext context) {
    final ceiling = (maxMinutes <= 0 ? 60 : maxMinutes).toDouble();

    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final p in points)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _ActiveHoursBar(
                  label: p.label,
                  minutes: p.minutes,
                  height: 110 * (p.minutes / ceiling).clamp(0.0, 1.0),
                  color: context.brandPrimaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActiveHoursBar extends StatelessWidget {
  final String label;
  final int minutes;
  final double height;
  final Color color;

  const _ActiveHoursBar({
    required this.label,
    required this.minutes,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Container(
          height: height.clamp(2.0, 110.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            color: context.textTertiaryColor,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Pair of stat columns showing current and longest streak.
class StreakStatsView extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final String currentLabel;
  final String longestLabel;
  final String Function(int days) daysLabelBuilder;

  const StreakStatsView({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.currentLabel,
    required this.longestLabel,
    required this.daysLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StreakColumn(
            label: currentLabel,
            value: daysLabelBuilder(currentStreak),
            icon: Icons.local_fire_department_rounded,
            color: context.statusDangerColor,
          ),
        ),
        const Gap(12),
        Expanded(
          child: _StreakColumn(
            label: longestLabel,
            value: daysLabelBuilder(longestStreak),
            icon: Icons.workspace_premium_rounded,
            color: context.brandPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class _StreakColumn extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StreakColumn({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const Gap(8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
            ),
          ),
          const Gap(4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Achievement tile (locked / unlocked).
class AchievementTileView extends StatelessWidget {
  final String title;
  final String description;
  final bool isUnlocked;

  const AchievementTileView({
    super.key,
    required this.title,
    required this.description,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isUnlocked
        ? context.brandPrimaryColor
        : context.textTertiaryColor;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUnlocked
                  ? Icons.emoji_events_rounded
                  : Icons.lock_outline_rounded,
              color: accent,
              size: 20,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const Gap(2),
                Text(
                  description,
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact tile for a quiz-speed summary (overall avg + total quizzes).
class QuizSpeedSummaryView extends StatelessWidget {
  final double averageSecondsPerQuestion;
  final int totalQuizzes;
  final String averageLabel;
  final String countLabel;

  const QuizSpeedSummaryView({
    super.key,
    required this.averageSecondsPerQuestion,
    required this.totalQuizzes,
    required this.averageLabel,
    required this.countLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.speed_rounded,
                  color: context.brandPrimaryColor,
                  size: 22,
                ),
                const Gap(8),
                Text(
                  averageLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.brandSecondaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.quiz_rounded,
                  color: context.brandSecondaryColor,
                  size: 22,
                ),
                const Gap(8),
                Text(
                  countLabel,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
