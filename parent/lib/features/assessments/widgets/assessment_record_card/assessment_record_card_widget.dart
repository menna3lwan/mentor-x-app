import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:intl/intl.dart';

/// Single assessment row card. Shows the quiz/assignment title prefix,
/// score-out-of-total, pass/fail badge, and graded date.
class AssessmentRecordCardWidget extends StatelessWidget {
  final QuizAttemptEntity attempt;
  final String titlePrefix;
  final String scoreLabel;
  final VoidCallback? onTap;

  const AssessmentRecordCardWidget({
    super.key,
    required this.attempt,
    required this.titlePrefix,
    required this.scoreLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = attempt.passed
        ? context.statusSuccessColor
        : context.statusDangerColor;
    final dateStr = attempt.submittedAt != null
        ? DateFormat('dd MMM').format(attempt.submittedAt!)
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.description_rounded,
                    color: context.brandPrimaryColor,
                    size: 22,
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attempt.courseName?.isNotEmpty == true
                            ? attempt.courseName!
                            : titlePrefix,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        dateStr.isEmpty ? scoreLabel : '$scoreLabel • $dateStr',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                StatusBadge(
                  label: _formatPercent(attempt.percentage),
                  color: statusColor,
                  isSmall: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Clamps the percentage to [0, 100] and rounds. Defensive against APIs
  /// that occasionally send NaN/infinity or values outside the normal range.
  static String _formatPercent(double raw) {
    if (raw.isNaN || raw.isInfinite) return '0%';
    return '${raw.clamp(0.0, 100.0).toInt()}%';
  }
}

class AssessmentRecordCardSkeleton extends StatelessWidget {
  const AssessmentRecordCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: MentorXSkeleton(height: 76, borderRadius: 20),
    );
  }
}
