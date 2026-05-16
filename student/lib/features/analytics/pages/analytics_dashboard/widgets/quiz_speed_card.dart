import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import 'analytics_section_card.dart';

final class QuizSpeedCard extends StatelessWidget {
  final List<QuizSpeedMetricEntity> metrics;

  const QuizSpeedCard({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    if (metrics.isEmpty) {
      return const SizedBox.shrink();
    }

    // Show the most recent or highest impact metric
    final recent = metrics.first;
    final speedDiff =
        recent.averageSecondsPerQuestion - recent.secondsPerQuestion;
    final isFaster = speedDiff > 0;

    return AnalyticsSectionCard(
      title: 'Quiz Performance',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recent.quizTitle,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${recent.questionCount} Questions in ${_formatTime(recent.timeSpentSeconds)}',
                      style: TextStyle(
                        color: context.textTertiaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isFaster
                      ? context.statusSuccessColor.withValues(alpha: 0.1)
                      : context.statusDangerColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isFaster ? Icons.bolt_rounded : Icons.timer_rounded,
                      color: isFaster
                          ? context.statusSuccessColor
                          : context.statusDangerColor,
                      size: 16,
                    ),
                    const Gap(6),
                    Text(
                      '${recent.secondsPerQuestion.toStringAsFixed(1)}s/q',
                      style: TextStyle(
                        color: isFaster
                            ? context.statusSuccessColor
                            : context.statusDangerColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          _ComparisonRow(
            label: 'Your Speed',
            seconds: recent.secondsPerQuestion,
            isStudent: true,
            maxSeconds: recent.averageSecondsPerQuestion * 1.2,
          ),
          const Gap(12),
          _ComparisonRow(
            label: 'Peer Average',
            seconds: recent.averageSecondsPerQuestion,
            isStudent: false,
            maxSeconds: recent.averageSecondsPerQuestion * 1.2,
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}m ${secs}s';
  }
}

final class _ComparisonRow extends StatelessWidget {
  final String label;
  final double seconds;
  final bool isStudent;
  final double maxSeconds;

  const _ComparisonRow({
    required this.label,
    required this.seconds,
    required this.isStudent,
    required this.maxSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final widthFactor = (seconds / maxSeconds).clamp(0.1, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isStudent
                    ? context.textPrimaryColor
                    : context.textTertiaryColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${seconds.toStringAsFixed(1)}s',
              style: TextStyle(
                color: isStudent
                    ? context.textPrimaryColor
                    : context.textTertiaryColor,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const Gap(6),
        Stack(
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isStudent
                        ? [
                            context.brandPrimaryColor,
                            context.brandPrimaryColor.withValues(alpha: 0.6),
                          ]
                        : [
                            context.textTertiaryColor,
                            context.textTertiaryColor.withValues(alpha: 0.6),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
