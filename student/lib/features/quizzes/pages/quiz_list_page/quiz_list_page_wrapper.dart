import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/quiz_list_page_bloc.dart';
import 'quiz_list_page_page.dart';

final class QuizListPageWrapper extends StatefulWidget {
  const QuizListPageWrapper({super.key});

  @override
  State<QuizListPageWrapper> createState() => _QuizListPageWrapperState();
}

class _QuizListPageWrapperState extends State<QuizListPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizListPageBloc,
      QuizListPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizListPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const QuizListPage();
        },
      ),
    );
  }
}
