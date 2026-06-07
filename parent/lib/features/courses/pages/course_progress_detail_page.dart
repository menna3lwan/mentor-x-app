import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';

final class CourseProgressDetailPage extends StatelessWidget {
  final CourseEntity course;

  const CourseProgressDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: 'Course Progress',
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
                    label: 'Sessions',
                    value: course.totalSessions.toString(),
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: 'Progress',
                    value: '85%', // Placeholder for progress
                    onTap: () {},
                  ),
                  AppHeroStatItem(
                    label: 'ID',
                    value: course.id.substring(0, 4),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Gap(32),
            
            FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: const AppSectionHeader(title: 'Course Breakdown'),
            ),
            const Gap(16),
            
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
                ),
                child: Column(
                  children: [
                    _DetailRow(label: 'Course ID', value: course.id),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    _DetailRow(label: 'Full Title', value: course.title),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const _DetailRow(label: 'Status', value: 'Active'),
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
