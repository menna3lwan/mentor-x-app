import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class CatalogCourseCard extends StatelessWidget {
  final CourseSummaryEntity course;
  final VoidCallback onTap;

  const CatalogCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  course.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: palette.backgroundSecondary,
                    child: Icon(
                      Icons.image_outlined,
                      color: palette.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course.isFree
                              ? context.t.course.detail.free
                              : '${course.price?.toInt() ?? 0} ${context.t.core.currency}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: course.isFree
                                    ? palette.statusSuccess
                                    : palette.brandPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 14,
                              color: palette.textSecondary,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${course.enrolledCount}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: palette.textSecondary),
                            ),
                          ],
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
