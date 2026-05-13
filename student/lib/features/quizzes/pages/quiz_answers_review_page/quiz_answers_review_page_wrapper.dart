import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';

import 'bloc/quiz_answers_review_page_bloc.dart';
import 'quiz_answers_review_page_page.dart';

final class QuizAnswersReviewPageWrapper extends StatefulWidget {
  const QuizAnswersReviewPageWrapper({super.key});

  @override
  State<QuizAnswersReviewPageWrapper> createState() =>
      _QuizAnswersReviewPageWrapperState();
}

class _QuizAnswersReviewPageWrapperState
    extends State<QuizAnswersReviewPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      QuizAnswersReviewPageBloc,
      QuizAnswersReviewPagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizAnswersReviewPageNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: Builder(
        builder: (context) {
          return const QuizAnswersReviewPage();
        },
      ),
    );
  }
}
