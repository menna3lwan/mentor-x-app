import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/quiz_review_bloc.dart';
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
      QuizReviewBloc,
      QuizReviewPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizReviewNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocListener<QuizReviewBloc, QuizReviewState>(
        listenWhen: (previous, current) =>
            previous.loadingState != current.loadingState &&
            current.loadingState == LoadingState.success,
        listener: (context, state) {
          if (state.result != null) {
            QuizResultRoute(attemptId: state.result!.id).go(context);
          }
        },
        child: const QuizReviewPage(),
      ),
    );
  }
}
