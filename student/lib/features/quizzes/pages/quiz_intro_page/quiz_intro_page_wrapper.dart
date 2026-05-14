import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'package:mentorx_student/features/quizzes/pages/quiz_intro_page/bloc/quiz_intro_page_bloc.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro_page/quiz_intro_page_page.dart';

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
          return const QuizIntroPage();
        },
      ),
    );
  }
}
