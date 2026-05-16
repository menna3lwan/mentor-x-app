import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class CourseAnalyticsCard extends StatelessWidget {
  final EnrollmentEntity enrollment;

  const CourseAnalyticsCard({
    super.key,
    required this.enrollment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(10),
              Text(
                context.t.course.detail.yourPerformance.toUpperCase(),
                style: context.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const Gap(16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 500),
                child: _CustomStatCard(
                  icon: Icons.auto_stories_rounded,
                  value:
                      '${enrollment.completedLessons}/${enrollment.totalLessons}',
                  label: context.t.course.lessonsCompleted,
                  iconColor: context.brandPrimaryColor,
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: _CustomStatCard(
                  icon: Icons.timer_rounded,
                  value: enrollment.timeSpentFormatted ?? '0m',
                  label: context.t.course.timeSpent,
                  iconColor: context.brandSecondaryColor,
                ),
              ),
              FadeInLeft(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: _CustomStatCard(
                  icon: Icons.quiz_rounded,
                  value: '${enrollment.quizzesTaken}',
                  label: context.t.course.quizzesTaken,
                  iconColor: context.statusWarningColor,
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: _CustomStatCard(
                  icon: Icons.stars_rounded,
                  value: '${enrollment.averageQuizScore.toInt()}%',
                  label: context.t.course.avgQuizScore,
                  iconColor: context.statusSuccessColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _CustomStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _CustomStatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(20),
      style: Style(
        $box.padding.all(12),
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.6)),
        $box.border.all.color(context.borderPrimaryColor.withValues(alpha: 0.1)),
        $box.shadows(context.softShadow),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const Gap(10),
          Text(
            value,
            style: context.titleH2Style.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(2),
          Text(
            label,
            style: context.smallTextStyle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: context.textSecondaryColor,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
