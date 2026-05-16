import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/analytics_dashboard_page_bloc.dart';
import 'analytics_dashboard_page.dart';

final class AnalyticsDashboardPageWrapper extends StatelessWidget {
  const AnalyticsDashboardPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsDashboardPageBloc(
        analyticsRepository: context.read<StudentAnalyticsRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AnalyticsDashboardPageLoadRequested()),
      child: Builder(
        builder: (context) {
          final status = context.select<
            AnalyticsDashboardPageBloc,
            AnalyticsDashboardStatus
          >((bloc) => bloc.state.status);
          final courses = context.select<
            AnalyticsDashboardPageBloc,
            List<EnrollmentEntity>
          >((bloc) => bloc.state.courses);
          final selectedCourseId = context.select<
            AnalyticsDashboardPageBloc,
            String?
          >((bloc) => bloc.state.selectedCourseId);
          final summary = context.select<
            AnalyticsDashboardPageBloc,
            StudentAnalyticsSummaryEntity?
          >((bloc) => bloc.state.summary);
          final errorMessage = context.select<
            AnalyticsDashboardPageBloc,
            String?
          >((bloc) => bloc.state.errorMessage);

          return AnalyticsDashboardPagePage(
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
              context.read<AnalyticsDashboardPageBloc>().add(
                const AnalyticsDashboardPageRefreshed(),
              );
            },
            onCourseChanged: (courseId) {
              context.read<AnalyticsDashboardPageBloc>().add(
                AnalyticsDashboardPageCourseChanged(courseId),
              );
            },
          );
        },
      ),
    );
  }
}
