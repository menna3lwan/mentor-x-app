import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class CourseProgressDetailPage extends StatelessWidget {
  final CourseEntity course;

  const CourseProgressDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return AppDashboardScaffold(
      title: t.courseDetail.pageTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: AppHeroCard(
                title: course.title.toUpperCase(),
                icon: Icons.auto_stories_rounded,
                stats: [
                  AppHeroStatItem(
                    label: t.courseDetail.sessions,
                    value: course.totalSessions.toString(),
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: t.courseDetail.progress,
                    value: '85%', // Placeholder for progress
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: t.courseDetail.id,
                    value: course.id.substring(0, 4),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Gap(32),

            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: AppSectionHeader(title: t.courseDetail.courseBreakdown),
            ),
            const Gap(16),

            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: context.textTertiaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      label: t.courseDetail.courseId,
                      value: course.id,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    _DetailRow(
                      label: t.courseDetail.fullTitle,
                      value: course.title,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    _DetailRow(
                      label: t.courseDetail.status,
                      value: t.courseDetail.statusActive,
                    ),
                  ],
                ),
              ),
            ),

            const Gap(40),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
