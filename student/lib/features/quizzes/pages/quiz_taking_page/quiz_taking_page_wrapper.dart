import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_taking_page_bloc.dart';
import 'quiz_taking_page_page.dart';

final class QuizTakingPageWrapper extends StatefulWidget {
  const QuizTakingPageWrapper({super.key});

  @override
  State<QuizTakingPageWrapper> createState() => _QuizTakingPageWrapperState();
}

class _QuizTakingPageWrapperState extends State<QuizTakingPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizTakingPageBloc,
      QuizTakingPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizTakingPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<QuizTakingPageBloc, QuizTakingPageState>(
        builder: (context, state) {
          return const QuizTakingPage();
        },
      ),
    );
  }
}
