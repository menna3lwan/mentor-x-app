import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_core/mentorx_core.dart';
import '../inline_section_error/inline_section_error_wrapper.dart';

final class FeaturedCoursesSectionWidget extends StatelessWidget {
  final List<CourseSummaryEntity>? courses;
  final bool isLoading;
  final bool hasFailedWithEmptyData;
  final VoidCallback onRetry;

  const FeaturedCoursesSectionWidget({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.hasFailedWithEmptyData,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (hasFailedWithEmptyData) {
      return InlineSectionError(onRetry: onRetry);
    }

    final palette = MentorXThemeColorPalette.light;
    final courseItems = courses ?? const <CourseSummaryEntity>[];

    return SizedBox(
      height: 250,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: courseItems.isEmpty ? 3 : courseItems.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final course = courseItems.isEmpty ? null : courseItems[index];
            final thumbnailUrl = course?.thumbnailUrl ??
                'https://picsum.photos/400/400?placeholder2';
            final title =
                course?.title ?? context.t.home.dashboard.loadingFeaturedCourse;
            final isFree = course?.isFree ?? true;
            final price = course?.price ?? 0;
            final enrolledCount = course?.enrolledCount ?? 100;

            return Container(
              width: 200,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: palette.backgroundPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    height: 140,
                    child: Image.network(thumbnailUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isFree
                                ? palette.statusSuccess.withValues(alpha: 0.15)
                                : palette.brandTertiary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            isFree
                                ? context.t.home.dashboard.free
                                : context.t.core.price(amount: price),
                            style: TextStyle(
                              fontSize: 12,
                              color: palette.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.people_alt_outlined,
                                size: 16, color: palette.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              '$enrolledCount',
                              style: TextStyle(
                                  color: palette.textSecondary, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
