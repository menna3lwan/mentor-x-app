import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/quiz_review_page_bloc.dart';
import 'quiz_review_page.dart';

final class QuizReviewPageWrapper extends StatefulWidget {
  const QuizReviewPageWrapper({super.key});

  @override
  State<QuizReviewPageWrapper> createState() => _QuizReviewPageWrapperState();
}

class _QuizReviewPageWrapperState extends State<QuizReviewPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizReviewPageBloc,
      QuizReviewPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizReviewPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: const QuizReviewPage(),
    );
  }
}
