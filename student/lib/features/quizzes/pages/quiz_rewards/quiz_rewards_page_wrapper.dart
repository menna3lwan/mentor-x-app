import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/quiz_rewards_bloc.dart';
import 'quiz_rewards_page.dart';

final class QuizRewardsPageWrapper extends StatefulWidget {
  const QuizRewardsPageWrapper({super.key});

  @override
  State<QuizRewardsPageWrapper> createState() => _QuizRewardsPageWrapperState();
}

class _QuizRewardsPageWrapperState extends State<QuizRewardsPageWrapper> {
  @override
  Widget build(BuildContext context) {
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
      child: const QuizRewardsPage(),
    );
  }
}
