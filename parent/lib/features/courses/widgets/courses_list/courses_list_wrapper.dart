import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import '../../bloc/courses_bloc.dart';
import '../course_card/course_card_widget.dart';

class CoursesListWrapper extends StatelessWidget {
  final ValueChanged<String>? onCourseTap;

  const CoursesListWrapper({super.key, this.onCourseTap});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<CoursesBloc, CoursesState>(
      buildWhen: (prev, curr) => prev.coursesSection != curr.coursesSection,
      builder: (context, state) {
        final section = state.coursesSection;

        if (section.isLoading && state.courses.isEmpty) {
          return Column(
            children: List.generate(
              4,
              (_) => const CourseCardSkeleton(),
            ),
          );
        }

        if (section.isFailure && state.courses.isEmpty) {
          return AppErrorView(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<CoursesBloc>().add(
              const CoursesRetrySectionRequested(CoursesSection.courses),
            ),
          );
        }

        if (state.courses.isEmpty) {
          return AppEmptyView(
            title: t.academic.noCoursesTitle,
            message: t.academic.noCoursesHint,
            icon: Icons.auto_stories_rounded,
          );
        }

        return Column(
          children: state.courses.asMap().entries.map((entry) {
            final index = entry.key;
            final course = entry.value;
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 50 * index),
              child: CourseCardWidget(
                course: course,
                sessionsLabel: t.academic.sessionsCount(
                  count: course.totalSessions,
                ),
                onTap: onCourseTap == null
                    ? null
                    : () => onCourseTap!(course.id),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
