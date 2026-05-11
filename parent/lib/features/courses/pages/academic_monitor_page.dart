import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import '../bloc/courses_bloc.dart';

class AcademicMonitorPage extends StatelessWidget {
  final String childId;

  const AcademicMonitorPage({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => CoursesBloc(
        courseRepository: context.read<ParentCourseRepository>(),
        gradeRepository: context.read<ParentGradeRepository>(),
      )..add(CoursesStarted(childId)),
      child: Builder(
        builder: (context) {
          return AppDashboardScaffold(
            title: t.academicMonitor,
            onRefresh: () async {
              context.read<CoursesBloc>().add(CoursesRefreshRequested(childId));
            },
            actions: [
              IconButton(
                onPressed: () => context.read<CoursesBloc>().add(CoursesRefreshRequested(childId)),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
            body: _AcademicMonitorBody(childId: childId),
          );
        },
      ),
    );
  }
}

class _AcademicMonitorBody extends StatelessWidget {
  const _AcademicMonitorBody({required this.childId});

  final String childId;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    final status = context.select((CoursesBloc bloc) => bloc.state.status);
    final errorMessage = context.select((CoursesBloc bloc) => bloc.state.errorMessage);
    final courses = context.select((CoursesBloc bloc) => bloc.state.courses);
    final gradeSummary = context.select((CoursesBloc bloc) => bloc.state.gradeSummary);

    if (status == CoursesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == CoursesStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: () => context.read<CoursesBloc>().add(CoursesStarted(childId)),
      );
    }

    if (courses.isEmpty && gradeSummary == null) {
      return AppEmptyView(
        title: t.noData,
        message: 'Academic data will appear here once available.',
        icon: Icons.auto_stories_rounded,
        onAction: () => context.read<CoursesBloc>().add(CoursesRefreshRequested(childId)),
        actionLabel: 'Refresh',
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        if (gradeSummary != null) ...[
          AppHeroCard(
            title: t.overallAverage.toUpperCase(),
            icon: Icons.auto_graph_rounded,
            stats: [
              AppHeroStatItem(
                label: 'Average',
                value: '${gradeSummary.overallAverage.toStringAsFixed(1)}%',
                onTap: () {},
              ),
              AppHeroStatItem(
                label: 'Graded',
                value: gradeSummary.graded.toString(),
                onTap: () {},
              ),
              AppHeroStatItem(
                label: 'Pending',
                value: gradeSummary.pending.toString(),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],

        AppSectionHeader(title: t.enrolledCourses),
        const SizedBox(height: 16),

        ...courses.map(
          (course) => _CourseCard(course: course),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}

// Removed _BuildHeader, _BuildGradeSummaryCard, and _DistributionItem in favor of standardized components

class _CourseCard extends StatelessWidget {
  final CourseEntity course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.book_rounded, color: context.brandPrimaryColor, size: 24),
        ),
        title: Text(
          course.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Sessions: ${course.totalSessions}',
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
            ),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: context.textTertiaryColor, size: 14),
        onTap: () {
          // Navigate to course details
        },
      ),
    );
  }
}
