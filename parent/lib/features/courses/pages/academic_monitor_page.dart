import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../bloc/courses_bloc.dart';
import '../widgets/widgets.dart';

class AcademicMonitorPage extends StatelessWidget {
  final String childId;

  const AcademicMonitorPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesBloc(
        courseRepository: context.read<ParentCourseRepository>(),
        gradeRepository: context.read<ParentGradeRepository>(),
      )..add(CoursesStarted(childId)),
      child: _AcademicMonitorView(childId: childId),
    );
  }
}

class _AcademicMonitorView extends StatelessWidget {
  final String childId;
  const _AcademicMonitorView({required this.childId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<CoursesBloc, CoursesPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case CoursesFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
        }
      },
      child: AppDashboardScaffold(
        title: t.academic.pageTitle,
        onRefresh: () async =>
            context.read<CoursesBloc>().add(CoursesRefreshRequested(childId)),
        actions: [
          IconButton(
            tooltip: t.retry,
            onPressed: () => context.read<CoursesBloc>().add(
              CoursesRefreshRequested(childId),
            ),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            const AcademicSummaryCardWrapper(),
            const Gap(32),
            AppSectionHeader(title: t.enrolledCourses),
            const Gap(16),
            CoursesListWrapper(
              onCourseTap: (courseId) => CourseProgressRoute(
                childId: childId,
                courseId: courseId,
              ).go(context),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
