import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/leaderboard_bloc.dart';
import 'leaderboard_page.dart';

final class LeaderboardPageWrapper extends StatelessWidget {
  final String? courseId;
  const LeaderboardPageWrapper({super.key, this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaderboardBloc>(
      create: (context) => LeaderboardBloc(
        leaderboardRepository: context.read<LeaderboardRepository>(),
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(LeaderboardLoadRequested(courseId: courseId)),
      child: Builder(
        builder: (context) {
          final state = context
              .select<LeaderboardBloc, LeaderboardState>(
                (bloc) => bloc.state,
              );
          return LeaderboardPage(
            state: state,
            onCourseChanged: (id) => context.read<LeaderboardBloc>().add(
              LeaderboardFilterChanged(id),
            ),
            onRefresh: () => context.read<LeaderboardBloc>().add(
              LeaderboardLoadRequested(courseId: state.selectedCourseId),
            ),
          );
        },
      ),
    );
  }
}
