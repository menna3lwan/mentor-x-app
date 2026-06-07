import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro/bloc/quiz_intro_bloc.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro/quiz_intro_page.dart';

final class QuizIntroPageWrapper extends StatefulWidget {
  const QuizIntroPageWrapper({super.key});

  @override
  State<QuizIntroPageWrapper> createState() => _QuizIntroPageWrapperState();
}

class _QuizIntroPageWrapperState extends State<QuizIntroPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizIntroBloc,
      QuizIntroPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizIntroNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select(
            (QuizIntroBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (QuizIntroBloc bloc) => bloc.state.errorMessage,
          );
          final quiz = context.select(
            (QuizIntroBloc bloc) => bloc.state.quiz,
          );
          final activeAttempt = context.select(
            (QuizIntroBloc bloc) => bloc.state.activeAttempt,
          );

          return QuizIntroPage(
            loadingState: loadingState,
            errorMessage: errorMessage,
            quiz: quiz,
            activeAttempt: activeAttempt,
            onRetry: () => context.read<QuizIntroBloc>().add(
              const QuizIntroLoadEvent(),
            ),
            onStartResume: () {
              if (quiz != null) {
                QuizTakingRoute(quizId: quiz.id).push(context);
              }
            },
          );
        },
      ),
    );
  }
}
