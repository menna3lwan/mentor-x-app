import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_core/mentorx_core.dart';
import '../inline_section_error/inline_section_error_wrapper.dart';

final class ContinueLearningSectionWidget extends StatelessWidget {
  final List<CourseSummaryEntity>? courses;
  final bool isLoading;
  final bool hasFailedWithEmptyData;
  final VoidCallback onRetry;
  final ValueChanged<String>? onTapCourse;

  const ContinueLearningSectionWidget({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.hasFailedWithEmptyData,
    required this.onRetry,
    this.onTapCourse,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    if (hasFailedWithEmptyData) {
      return InlineSectionError(onRetry: onRetry);
    }

    final courseItems = courses ?? const <CourseSummaryEntity>[];
    if (courseItems.isEmpty && !isLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: palette.backgroundPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(context.t.home.dashboard.startLearningJourney),
      );
    }

    return SizedBox(
      height: 220,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: courseItems.isEmpty ? 2 : courseItems.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final course = courseItems.isEmpty ? null : courseItems[index];
            final thumbnailUrl =
                course?.thumbnailUrl ??
                'https://picsum.photos/500/300?placeholder';
            final title =
                course?.title ?? context.t.home.dashboard.loadingCourse;
            final progressPercent = course?.progressPercent ?? 45;

            return Material(
              color: palette.backgroundPrimary,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: course == null
                    ? null
                    : () => onTapCourse?.call(course.id),
                child: SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: palette.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: progressPercent / 100,
                                minHeight: 8,
                                backgroundColor: palette.backgroundTertiary,
                                color: palette.brandPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                context.t.home.dashboard.continueProgress(
                                  progress: progressPercent,
                                ),
                                style: TextStyle(
                                  color: palette.brandPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
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
