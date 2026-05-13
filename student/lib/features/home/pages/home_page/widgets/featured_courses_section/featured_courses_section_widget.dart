import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

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

    final courseItems = courses ?? const <CourseSummaryEntity>[];

    return SizedBox(
      height: 270,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: courseItems.isEmpty ? 3 : courseItems.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          separatorBuilder: (context, index) => const Gap(20),
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

            return GestureDetector(
              onTap: course == null ? null : () => onTapCourse?.call(course.id),
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: const SizedBox.expand(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppDynamicImage(thumbnailUrl, fit: BoxFit.cover),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.2),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      isFree
                                          ? context.t.home.dashboard.free
                                          : context.t.core.price(amount: price),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: context.brandPrimaryColor,
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
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                    height: 1.3,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                const Gap(12),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: context.brandPrimaryColor.withValues(
                                          alpha: 0.1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.people_alt_rounded,
                                        size: 14,
                                        color: context.brandPrimaryColor,
                                      ),
                                    ),
                                    const Gap(8),
                                    Text(
                                      '$enrolledCount ${context.t.course.detail.students}',
                                      style: TextStyle(
                                        color: context.textSecondaryColor,
                                        fontSize: 12,
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
