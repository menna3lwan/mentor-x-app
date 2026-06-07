import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/quiz_review_bloc.dart';
import 'quiz_review_page.dart';

final class QuizReviewPageWrapper extends StatelessWidget {
  const QuizReviewPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<QuizReviewBloc, bool>(
      (bloc) => bloc.state.loadingState == LoadingState.loading,
    );
    final isSubmitting = context.select<QuizReviewBloc, bool>(
      (bloc) => bloc.state.loadingState == LoadingState.actionInProgress,
    );
    final errorMessage = context.select<QuizReviewBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    final questions = context.select<QuizReviewBloc, List<QuizQuestionEntity>>(
      (bloc) => bloc.state.questions,
    );
    final answers = context.select<QuizReviewBloc, Map<String, String>>(
      (bloc) => bloc.state.answers,
    );

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
        child: QuizReviewPage(
          isLoading: isLoading,
          isSubmitting: isSubmitting,
          errorMessage: errorMessage,
          questions: questions,
          answers: answers,
          onRetry: () {
            final bloc = context.read<QuizReviewBloc>();
            bloc.add(const QuizReviewLoadEvent());
          },
          onSubmit: () {
            final bloc = context.read<QuizReviewBloc>();
            bloc.add(const QuizReviewSubmitEvent());
          },
        ),
      ),
    );
  }
}
