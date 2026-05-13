import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

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
    if (hasFailedWithEmptyData) {
      return InlineSectionError(onRetry: onRetry);
    }

    final courseItems = courses ?? const <CourseSummaryEntity>[];
    if (courseItems.isEmpty && !isLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_stories_rounded,
                color: context.brandPrimaryColor,
                size: 40,
              ),
            ),
            const Gap(16),
            Text(
              context.t.home.dashboard.startLearningJourney,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 230,
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: courseItems.isEmpty ? 2 : courseItems.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          separatorBuilder: (context, index) => const Gap(20),
          itemBuilder: (context, index) {
            final course = courseItems.isEmpty ? null : courseItems[index];
            final thumbnailUrl =
                course?.thumbnailUrl ??
                'https://picsum.photos/500/300?placeholder';
            final title =
                course?.title ?? context.t.home.dashboard.loadingCourse;
            final progressPercent = course?.progressPercent ?? 45;

            return GestureDetector(
              onTap: course == null ? null : () => onTapCourse?.call(course.id),
              child: Container(
                width: 280,
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
                                AppDynamicImage(
                                  thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
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
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: context.brandPrimaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: context.textPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    letterSpacing: -0.6,
                                  ),
                                ),
                                const Gap(14),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: context.backgroundPrimaryColor
                                                  .withValues(alpha: 0.5),
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(milliseconds: 600),
                                            height: 6,
                                            width: (280 - 40 - 50) * (progressPercent / 100),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  context.brandPrimaryColor,
                                                  context.brandSecondaryColor,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: context.brandPrimaryColor
                                                      .withValues(alpha: 0.2),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(12),
                                    Text(
                                      '${progressPercent.toInt()}%',
                                      style: TextStyle(
                                        color: context.brandPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                        letterSpacing: -0.2,
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
