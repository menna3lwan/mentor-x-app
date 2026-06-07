import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/quiz_rewards_bloc.dart';
import 'quiz_rewards_page.dart';

final class QuizRewardsPageWrapper extends StatelessWidget {
  const QuizRewardsPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingState = context.select<QuizRewardsBloc, LoadingState>(
      (bloc) => bloc.state.loadingState,
    );
    final leaderboardEntries = context.select<QuizRewardsBloc, List<LeaderboardEntryEntity>>(
      (bloc) => bloc.state.leaderboardEntries,
    );

    return BlocPresentationListener<
      QuizRewardsBloc,
      QuizRewardsPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizRewardsNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: QuizRewardsPage(
        loadingState: loadingState,
        leaderboardEntries: leaderboardEntries,
        onRetry: () {
          final bloc = context.read<QuizRewardsBloc>();
          bloc.add(const QuizRewardsLoadEvent());
        },
      ),
    );
  }
}
