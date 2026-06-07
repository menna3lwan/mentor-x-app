import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/quiz_list_bloc.dart';
import 'quiz_list_page.dart';

final class QuizListPageWrapper extends StatefulWidget {
  const QuizListPageWrapper({super.key});

  @override
  State<QuizListPageWrapper> createState() => _QuizListPageWrapperState();
}

class _QuizListPageWrapperState extends State<QuizListPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizListBloc,
      QuizListPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizListNavigateBack():
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
