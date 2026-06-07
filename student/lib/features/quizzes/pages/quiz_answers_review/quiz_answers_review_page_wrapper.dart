import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/quiz_answers_review_bloc.dart';
import 'quiz_answers_review_page.dart';

final class QuizAnswersReviewPageWrapper extends StatelessWidget {
  const QuizAnswersReviewPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<QuizAnswersReviewBloc, bool>(
      (bloc) => bloc.state.loadingState == LoadingState.loading,
    );
    final errorMessage = context.select<QuizAnswersReviewBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    final attempt = context.select<QuizAnswersReviewBloc, QuizAttemptEntity?>(
      (bloc) => bloc.state.attempt,
    );
    final questions = context.select<QuizAnswersReviewBloc, List<QuizQuestionEntity>>(
      (bloc) => bloc.state.questions,
    );

    return BlocPresentationListener<
      QuizAnswersReviewBloc,
      QuizAnswersReviewPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizAnswersReviewNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: QuizAnswersReviewPage(
        isLoading: isLoading,
        errorMessage: errorMessage,
        attempt: attempt,
        questions: questions,
        onRetry: () {
          final bloc = context.read<QuizAnswersReviewBloc>();
          bloc.add(const QuizAnswersReviewLoadEvent());
        },
      ),
    );
  }
}
