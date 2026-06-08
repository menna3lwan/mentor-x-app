import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// Vertical list of the most recent quiz/assignment/exam grades.
class RecentGradesWidget extends StatelessWidget {
  final List<ParentRecentGradeEntity> grades;
  final ValueChanged<ParentRecentGradeEntity>? onGradeTap;

  const RecentGradesWidget({
    super.key,
    required this.grades,
    this.onGradeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: grades.asMap().entries.map((entry) {
        final index = entry.key;
        final grade = entry.value;

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 80 * index),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: index == grades.length - 1 ? 0 : 10,
            ),
            child: _GradeTile(
              grade: grade,
              onTap: onGradeTap == null ? null : () => onGradeTap!(grade),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _GradeTile extends StatelessWidget {
  final ParentRecentGradeEntity grade;
  final VoidCallback? onTap;

  const _GradeTile({required this.grade, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor(context);
    final dateStr = DateFormat('dd MMM').format(grade.gradedAt);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_kindIcon(), color: accent, size: 22),
              ),
              const Gap(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      grade.title.isEmpty ? grade.kind.name : grade.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: context.textPrimaryColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${grade.courseName} • $dateStr',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: context.textTertiaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${grade.percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: accent,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    grade.scoreLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: context.textTertiaryColor,
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

  Color _accentColor(BuildContext context) {
    if (grade.passed == false) return context.statusDangerColor;
    if (grade.percentage >= 80) return context.statusSuccessColor;
    if (grade.percentage >= 60) return context.brandPrimaryColor;
    if (grade.percentage > 0) return context.statusWarningColor;
    return context.textTertiaryColor;
  }

  IconData _kindIcon() {
    switch (grade.kind) {
      case ParentGradeKind.quiz:
        return Icons.quiz_rounded;
      case ParentGradeKind.assignment:
        return Icons.assignment_turned_in_rounded;
      case ParentGradeKind.exam:
        return Icons.menu_book_rounded;
      case ParentGradeKind.project:
        return Icons.science_rounded;
      case ParentGradeKind.other:
        return Icons.grade_rounded;
    }
  }
}

class RecentGradesSkeleton extends StatelessWidget {
  const RecentGradesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i == 2 ? 0 : 10),
          child: const MentorXSkeleton(height: 76, borderRadius: 20),
        ),
      ),
    );
  }
}

class RecentGradesEmpty extends StatelessWidget {
  final String message;
  const RecentGradesEmpty({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.grade_outlined,
            color: context.textTertiaryColor,
            size: 28,
          ),
          const Gap(12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
