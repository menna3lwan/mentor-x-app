import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro/bloc/quiz_intro_page_bloc.dart';
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
      QuizIntroPageBloc,
      QuizIntroPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizIntroPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          final loadingState = context.select(
            (QuizIntroPageBloc bloc) => bloc.state.loadingState,
          );
          final errorMessage = context.select(
            (QuizIntroPageBloc bloc) => bloc.state.errorMessage,
          );
          final quiz = context.select(
            (QuizIntroPageBloc bloc) => bloc.state.quiz,
          );
          final activeAttempt = context.select(
            (QuizIntroPageBloc bloc) => bloc.state.activeAttempt,
          );

          return QuizIntroPagePage(
            loadingState: loadingState,
            errorMessage: errorMessage,
            quiz: quiz,
            activeAttempt: activeAttempt,
            onRetry: () => context.read<QuizIntroPageBloc>().add(
                  const QuizIntroPageLoadEvent(),
                ),
            onStartResume: () {
              if (quiz != null) {
                QuizTakingPageRoute(quizId: quiz.id).push(context);
              }
            },
          );
        },
      ),
    );
  }
}
