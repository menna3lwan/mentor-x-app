import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'analytics_section_card.dart';

final class GradeComparisonCard extends StatelessWidget {
  final int rank;
  final int totalStudents;
  final double studentAverage;
  final double classAverage;

  final VoidCallback? onTap;

  const GradeComparisonCard({
    super.key,
    required this.rank,
    required this.totalStudents,
    required this.studentAverage,
    required this.classAverage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.analytics;

    return AnalyticsSectionCard(
      title: t.gradeVsPeers,
      onTap: onTap,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.brandSecondaryColor,
              context.brandSecondaryColor.withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.brandSecondaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          context.t.analytics.rank(rank: rank.toString()),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: -0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGradeCircle(
            context: context,
            value: studentAverage / 100,
            label: context.t.analytics.yourScore,
            color: context.brandSecondaryColor,
            scoreText: '${studentAverage.toInt()}%',
            isPrimary: true,
          ),
          _buildGradeCircle(
            context: context,
            value: classAverage / 100,
            label: context.t.analytics.classAverage,
            color: context.brandPrimaryColor,
            scoreText: '${classAverage.toInt()}%',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.studentsCount(count: totalStudents),
                style: TextStyle(
                  color: context.textTertiaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(6),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color:
                          (studentAverage >= classAverage
                                  ? context.statusSuccessColor
                                  : context.statusDangerColor)
                              .withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      studentAverage >= classAverage
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      color: studentAverage >= classAverage
                          ? context.statusSuccessColor
                          : context.statusDangerColor,
                      size: 16,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    studentAverage >= classAverage
                        ? t.aboveAverage
                        : t.belowAverage,
                    style: TextStyle(
                      color: studentAverage >= classAverage
                          ? context.statusSuccessColor
                          : context.statusDangerColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeCircle({
    required BuildContext context,
    required double value,
    required String label,
    required Color color,
    required String scoreText,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: isPrimary ? 80 : 64,
              width: isPrimary ? 80 : 64,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: isPrimary ? 10 : 8,
                backgroundColor: context.backgroundTertiaryColor.withValues(
                  alpha: 0.1,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeCap: StrokeCap.round,
              ),
            ),
            Text(
              scoreText,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: isPrimary ? 20 : 16,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const Gap(12),
        Text(
          label,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
