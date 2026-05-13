import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/leaderboard_page_bloc.dart';
import 'leaderboard_page_page.dart';

final class LeaderboardPageWrapper extends StatelessWidget {
  final String? courseId;
  const LeaderboardPageWrapper({super.key, this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaderboardPageBloc>(
      create: (context) => LeaderboardPageBloc(
        leaderboardRepository: context.read<LeaderboardRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(LeaderboardPageLoadRequested(courseId: courseId)),
      child: Builder(
        builder: (context) {
          final state = context.select<
            LeaderboardPageBloc,
            LeaderboardPageState
          >((bloc) => bloc.state);
          return LeaderboardPagePage(
            state: state,
            onCourseChanged: (id) => context.read<LeaderboardPageBloc>().add(
              LeaderboardPageFilterChanged(id),
            ),
            onRefresh: () => context.read<LeaderboardPageBloc>().add(
              LeaderboardPageLoadRequested(courseId: state.selectedCourseId),
            ),
          );
        },
      ),
    );
  }
}
