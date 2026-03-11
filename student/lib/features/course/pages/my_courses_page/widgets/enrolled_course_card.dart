import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class EnrolledCourseCard extends StatelessWidget {
  final CourseSummaryEntity course;
  final VoidCallback onTap;

  const EnrolledCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final progress = course.progressPercent ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: palette.backgroundPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(12),
                bottomStart: Radius.circular(12),
              ),
              child: Image.network(
                course.thumbnailUrl,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 90,
                  color: palette.backgroundSecondary,
                  child: Icon(
                    Icons.image_outlined,
                    color: palette.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress / 100,
                              minHeight: 6,
                              backgroundColor: palette.backgroundSecondary,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress >= 100
                                    ? palette.statusSuccess
                                    : palette.brandPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${progress.toInt()}%',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: palette.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
