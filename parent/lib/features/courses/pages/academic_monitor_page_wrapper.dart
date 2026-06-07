import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/courses_bloc.dart';
import 'academic_monitor_page.dart';

final class AcademicMonitorPageWrapper extends StatelessWidget {
  final String childId;

  const AcademicMonitorPageWrapper({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesBloc(
        courseRepository: context.read<ParentCourseRepository>(),
        gradeRepository: context.read<ParentGradeRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(CoursesStarted(childId)),
      child: Builder(
        builder: (context) {
          final status = context.select<CoursesBloc, CoursesStatus>(
            (bloc) => bloc.state.status,
          );
          final errorMessage = context.select<CoursesBloc, String?>(
            (bloc) => bloc.state.errorMessage,
          );
          final courses = context.select<CoursesBloc, List<CourseEntity>>(
            (bloc) => bloc.state.courses,
          );
          final gradeSummary = context.select<CoursesBloc, ParentGradeSummaryEntity?>(
            (bloc) => bloc.state.gradeSummary,
          );

          return AcademicMonitorPage(
            status: status,
            errorMessage: errorMessage,
            courses: courses,
            gradeSummary: gradeSummary,
            onRefresh: () {
              final bloc = context.read<CoursesBloc>();
              bloc.add(CoursesRefreshRequested(childId));
            },
            onRetry: () {
              final bloc = context.read<CoursesBloc>();
              bloc.add(CoursesStarted(childId));
            },
          );
        },
      ),
    );
  }
}
