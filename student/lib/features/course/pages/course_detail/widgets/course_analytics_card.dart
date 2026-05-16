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
            childAspectRatio: 1.2,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 500),
                child: StatCard(
                  icon: Icons.auto_stories_rounded,
                  value:
                      '${enrollment.completedLessons}/${enrollment.totalLessons}',
                  label: 'Lessons Completed',
                  iconColor: context.brandPrimaryColor,
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: StatCard(
                  icon: Icons.timer_rounded,
                  value: enrollment.timeSpentFormatted ?? '0m',
                  label: 'Time Spent',
                  iconColor: context.brandSecondaryColor,
                ),
              ),
              FadeInLeft(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: StatCard(
                  icon: Icons.quiz_rounded,
                  value: '${enrollment.quizzesTaken}',
                  label: 'Quizzes Taken',
                  iconColor: context.statusWarningColor,
                ),
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: StatCard(
                  icon: Icons.stars_rounded,
                  value: '${enrollment.averageQuizScore.toInt()}%',
                  label: 'Avg. Quiz Score',
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
