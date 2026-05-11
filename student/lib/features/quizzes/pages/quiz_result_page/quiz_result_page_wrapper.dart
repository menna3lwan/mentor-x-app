import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

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
      child: const QuizResultPage(),
    );
  }
}
