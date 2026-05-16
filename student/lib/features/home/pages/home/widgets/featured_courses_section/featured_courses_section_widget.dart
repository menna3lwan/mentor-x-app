import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_student/core/core.dart';
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

    final courseItems = courses ?? const <CourseSummaryEntity>[];

    return SizedBox(
      height: 280,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: courseItems.isEmpty ? 3 : courseItems.length,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          separatorBuilder: (context, index) => const Gap(16),
          itemBuilder: (context, index) {
            final course = courseItems.isEmpty ? null : courseItems[index];
            return _FeaturedCourseCard(
              course: course,
              onTap: course == null ? null : () => onTapCourse?.call(course.id),
            );
          },
        ),
      ),
    );
  }
}

class _FeaturedCourseCard extends StatelessWidget {
  final CourseSummaryEntity? course;
  final VoidCallback? onTap;

  const _FeaturedCourseCard({this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl =
        course?.thumbnailUrl ?? 'https://picsum.photos/400/400?placeholder2';
    final title =
        course?.title ?? context.t.home.dashboard.loadingFeaturedCourse;
    final isFree = course?.isFree ?? true;
    final price = course?.price ?? 0;
    final enrolledCount = course?.enrolledCount ?? 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppDynamicImage(thumbnailUrl, fit: BoxFit.cover),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.brandSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: context.brandSecondaryColor.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          isFree
                              ? context.t.home.dashboard.free
                              : context.t.core.price(amount: price),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        height: 1.3,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        Icon(
                          Icons.people_alt_rounded,
                          size: 14,
                          color: context.textTertiaryColor,
                        ),
                        const Gap(6),
                        Text(
                          '$enrolledCount ${context.t.course.detail.students}',
                          style: TextStyle(
                            color: context.textTertiaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
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
  }
}
