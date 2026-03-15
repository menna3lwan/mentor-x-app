import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_rewards_page_bloc.dart';
import 'quiz_rewards_page_page.dart';

final class QuizRewardsPageWrapper extends StatefulWidget {
  const QuizRewardsPageWrapper({super.key});

  @override
  State<QuizRewardsPageWrapper> createState() => _QuizRewardsPageWrapperState();
}

class _QuizRewardsPageWrapperState extends State<QuizRewardsPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizRewardsPageBloc,
      QuizRewardsPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizRewardsPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<QuizRewardsPageBloc, QuizRewardsPageState>(
        builder: (context, state) {
          return const QuizRewardsPage();
        },
      ),
    );
  }
}
