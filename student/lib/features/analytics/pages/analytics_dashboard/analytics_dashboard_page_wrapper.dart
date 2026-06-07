import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/analytics_dashboard_bloc.dart';
import 'analytics_dashboard_page.dart';

final class AnalyticsDashboardPageWrapper extends StatelessWidget {
  const AnalyticsDashboardPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsDashboardBloc(
        analyticsRepository: context.read<StudentAnalyticsRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AnalyticsDashboardLoadRequested()),
      child: Builder(
        builder: (context) {
          final status = context
              .select<AnalyticsDashboardBloc, AnalyticsDashboardStatus>(
                (bloc) => bloc.state.status,
              );
          final courses = context
              .select<AnalyticsDashboardBloc, List<EnrollmentEntity>>(
                (bloc) => bloc.state.courses,
              );
          final selectedCourseId = context
              .select<AnalyticsDashboardBloc, String?>(
                (bloc) => bloc.state.selectedCourseId,
              );
          final summary = context
              .select<
                AnalyticsDashboardBloc,
                StudentAnalyticsSummaryEntity?
              >((bloc) => bloc.state.summary);
          final errorMessage = context
              .select<AnalyticsDashboardBloc, String?>(
                (bloc) => bloc.state.errorMessage,
              );

          return AnalyticsDashboardPage(
            status: status,
            courses: courses,
            selectedCourseId: selectedCourseId,
            rank: summary?.rank,
            totalStudents: summary?.totalStudents,
            studentAverage: summary?.studentAverage,
            classAverage: summary?.classAverage,
            performanceTimeline: summary?.performanceTimeline,
            activityHeatmap: summary?.activityHeatmap,
            achievements: summary?.achievements,
            streak: summary?.streak,
            quizSpeedMetrics: summary?.quizSpeedMetrics,
            errorMessage: errorMessage,
            onRefresh: () async {
              context.read<AnalyticsDashboardBloc>().add(
                const AnalyticsDashboardRefreshed(),
              );
            },
            onCourseChanged: (courseId) {
              context.read<AnalyticsDashboardBloc>().add(
                AnalyticsDashboardCourseChanged(courseId),
              );
            },
          );
        },
      ),
    );
  }
}
