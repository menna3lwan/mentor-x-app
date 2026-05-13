import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Positioned.fill(
                child: ExcludeSemantics(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1.1,
                          child: Hero(
                            tag: 'catalog_course_${course.id}',
                            child: AppDynamicImage(
                              course.thumbnailUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: context.backgroundPrimaryColor.withValues(
                              alpha: 0.6,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Text(
                                course.isFree
                                    ? context.t.course.detail.free
                                    : '${course.price?.toInt() ?? 0} ${context.t.core.currency}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: course.isFree
                                      ? context.statusSuccessColor
                                      : context.brandPrimaryColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: context.textPrimaryColor,
                            height: 1.2,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: context.brandPrimaryColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.people_alt_rounded,
                                size: 10,
                                color: context.brandPrimaryColor,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              '${course.enrolledCount} ${context.t.course.detail.students}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: context.textSecondaryColor.withValues(alpha: 0.7),
                                letterSpacing: 0.2,
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
  }
}
