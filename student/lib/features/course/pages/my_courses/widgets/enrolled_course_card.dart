import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class EnrolledCourseCard extends StatelessWidget {
  final EnrollmentEntity course;
  final VoidCallback onTap;

  const EnrolledCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = course.progressPercent;
    final isCompleted = course.status == EnrollmentStatus.completed;

    return GestureDetector(
      onTap: onTap,
      child: MentorXGlassCard(
        borderRadius: BorderRadius.circular(24),
        style: Style(
          $box.padding.all(0), // No padding for the card itself
          $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.6)),
          $box.border.all.color(context.borderPrimaryColor.withValues(alpha: 0.1)),
          $box.shadows(context.softShadow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail at top
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Hero(
                      tag: 'course_image_${course.courseId}',
                      child: AppDynamicImage(
                        course.courseThumbnailUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
                // Status badges on thumbnail
                if (isCompleted)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: context.statusSuccessColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 14),
                          Gap(4),
                          Text(
                            'COMPLETED',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (course.remainingDays > 0)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: context.statusWarningColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined, color: Colors.white, size: 14),
                          const Gap(4),
                          Text(
                            '${course.remainingDays} DAYS LEFT',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            
            // Content below
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.courseTitle ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.2,
                      height: 1.2,
                    ),
                  ),
                  const Gap(12),
                  // Stats
                  Row(
                    children: [
                      _StatBadge(
                        icon: Icons.play_circle_outline_rounded,
                        label: '${course.completedLessons}/${course.totalLessons} Lessons',
                        color: context.brandPrimaryColor,
                      ),
                      const Gap(8),
                      if (course.averageQuizScore > 0)
                        _StatBadge(
                          icon: Icons.assessment_outlined,
                          label: '${course.averageQuizScore.toInt()}% Avg',
                          color: context.brandSecondaryColor,
                        ),
                    ],
                  ),
                  const Gap(16),
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: context.backgroundSecondaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: (progress / 100).clamp(0.02, 1.0),
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      isCompleted ? context.statusSuccessColor : context.brandPrimaryColor,
                                      isCompleted ? context.statusSuccessColor.withValues(alpha: 0.8) : context.brandSecondaryColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                      Text(
                        '${progress.toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: isCompleted ? context.statusSuccessColor : context.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const Gap(6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
