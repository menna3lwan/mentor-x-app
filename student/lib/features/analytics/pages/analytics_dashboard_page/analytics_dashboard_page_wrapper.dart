import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'bloc/analytics_dashboard_page_bloc.dart';
import 'analytics_dashboard_page_page.dart';

final class AnalyticsDashboardPageWrapper extends StatelessWidget {
  const AnalyticsDashboardPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsDashboardPageBloc(
        analyticsRepository: context.read<StudentAnalyticsRepository>(),
        courseRepository: context.read<CourseRepository>(),
      )..add(const AnalyticsDashboardPageLoadRequested()),
      child:
          BlocBuilder<AnalyticsDashboardPageBloc, AnalyticsDashboardPageState>(
            builder: (context, state) {
              final summary = state.summary;
              return AnalyticsDashboardPagePage(
                status: state.status,
                courses: state.courses,
                selectedCourseId: state.selectedCourseId,
                rank: summary?.rank,
                totalStudents: summary?.totalStudents,
                studentAverage: summary?.studentAverage,
                classAverage: summary?.classAverage,
                performanceTimeline: summary?.performanceTimeline,
                activityHeatmap: summary?.activityHeatmap,
                achievements: summary?.achievements,
                streak: summary?.streak,
                quizSpeedMetrics: summary?.quizSpeedMetrics,
                errorMessage: state.errorMessage,
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
