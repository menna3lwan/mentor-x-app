import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_result_page_bloc.dart';
import 'quiz_result_page_page.dart';

final class QuizResultPageWrapper extends StatefulWidget {
  const QuizResultPageWrapper({super.key});

  @override
  State<QuizResultPageWrapper> createState() => _QuizResultPageWrapperState();
}

class _QuizResultPageWrapperState extends State<QuizResultPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizResultPageBloc,
      QuizResultPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizResultPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select(
            (QuizResultPageBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (QuizResultPageBloc bloc) => bloc.state.errorMessage,
          );
          final result = context.select(
            (QuizResultPageBloc bloc) => bloc.state.result,
          );
          final leaderboard = context.select(
            (QuizResultPageBloc bloc) => bloc.state.leaderboard,
          );
          final myRank = context.select(
            (QuizResultPageBloc bloc) => bloc.state.myRank,
          );

          return QuizResultPagePage(
            loadingState: loadingState,
            errorMessage: errorMessage,
            result: result,
            leaderboard: leaderboard,
            myRank: myRank,
            onRetry: () {
              if (result != null) {
                context.read<QuizResultPageBloc>().add(
                  QuizResultPageLoadEvent(attemptId: result.id),
                );
              }
            },
          );
        },
      ),
    );
  }
}
