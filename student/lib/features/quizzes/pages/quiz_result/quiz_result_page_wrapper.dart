import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_result_bloc.dart';
import 'quiz_result_page.dart';

final class QuizResultPageWrapper extends StatefulWidget {
  const QuizResultPageWrapper({super.key});

  @override
  State<QuizResultPageWrapper> createState() => _QuizResultPageWrapperState();
}

class _QuizResultPageWrapperState extends State<QuizResultPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizResultBloc,
      QuizResultPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizResultNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select(
            (QuizResultBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (QuizResultBloc bloc) => bloc.state.errorMessage,
          );
          final result = context.select(
            (QuizResultBloc bloc) => bloc.state.result,
          );
          final leaderboard = context.select(
            (QuizResultBloc bloc) => bloc.state.leaderboard,
          );
          final myRank = context.select(
            (QuizResultBloc bloc) => bloc.state.myRank,
          );

          return QuizResultPage(
            loadingState: loadingState,
            errorMessage: errorMessage,
            result: result,
            leaderboard: leaderboard,
            myRank: myRank,
            onRetry: () {
              if (result != null) {
                context.read<QuizResultBloc>().add(
                  QuizResultLoadEvent(attemptId: result.id),
                );
              }
            },
          );
        },
      ),
    );
  }
}
