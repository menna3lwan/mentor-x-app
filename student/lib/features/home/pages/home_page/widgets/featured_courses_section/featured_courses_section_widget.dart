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
  final ValueChanged<String>? onTapCourse;

  const FeaturedCoursesSectionWidget({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.hasFailedWithEmptyData,
    required this.onRetry,
    this.onTapCourse,
  });

  @override
  Widget build(BuildContext context) {
    if (hasFailedWithEmptyData) {
      return InlineSectionError(onRetry: onRetry);
    }

    final palette = MentorXThemeColorPalette.light;
    final courseItems = courses ?? const <CourseSummaryEntity>[];

    return SizedBox(
      height: 270,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: courseItems.isEmpty ? 3 : courseItems.length,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final course = courseItems.isEmpty ? null : courseItems[index];
            final thumbnailUrl =
                course?.thumbnailUrl ??
                'https://picsum.photos/400/400?placeholder2';
            final title =
                course?.title ?? context.t.home.dashboard.loadingFeaturedCourse;
            final isFree = course?.isFree ?? true;
            final price = course?.price ?? 0;
            final enrolledCount = course?.enrolledCount ?? 100;

            return Container(
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: palette.textPrimary.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: palette.backgroundPrimary,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: course == null
                      ? null
                      : () => onTapCourse?.call(course.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(thumbnailUrl, fit: BoxFit.cover),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: (isFree ? palette.statusSuccess : palette.brandPrimary).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  isFree
                                      ? context.t.home.dashboard.free
                                      : context.t.core.price(amount: price),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: palette.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: palette.brandTertiary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.people_alt_rounded,
                                    size: 14,
                                    color: palette.brandPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '$enrolledCount Students',
                                  style: TextStyle(
                                    color: palette.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
