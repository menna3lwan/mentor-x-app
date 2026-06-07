import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

import 'bloc/quiz_taking_bloc.dart';
import 'quiz_taking_page.dart';

final class QuizTakingPageWrapper extends StatefulWidget {
  const QuizTakingPageWrapper({super.key});

  @override
  State<QuizTakingPageWrapper> createState() => _QuizTakingPageWrapperState();
}

class _QuizTakingPageWrapperState extends State<QuizTakingPageWrapper> {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<QuizTakingBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final isSubmitting = context.select<QuizTakingBloc, bool>(
      (bloc) => bloc.state.isSubmitting,
    );
    final errorMessage = context.select<QuizTakingBloc, String?>(
      (bloc) => bloc.state.errorMessage,
    );
    final quiz = context.select<QuizTakingBloc, QuizEntity?>(
      (bloc) => bloc.state.quiz,
    );
    final questions = context.select<QuizTakingBloc, List<QuizQuestionEntity>>(
      (bloc) => bloc.state.questions,
    );
    final currentQuestionIndex = context.select<QuizTakingBloc, int>(
      (bloc) => bloc.state.currentQuestionIndex,
    );
    final answers = context.select<QuizTakingBloc, Map<String, String>>(
      (bloc) => bloc.state.answers,
    );
    final remainingSeconds = context.select<QuizTakingBloc, int?>(
      (bloc) => bloc.state.remainingSeconds,
    );
    final quizId = context.select<QuizTakingBloc, String>(
      (bloc) => bloc.state.quizId,
    );
    final attemptId = context.select<QuizTakingBloc, String?>(
      (bloc) => bloc.state.attemptId,
    );

    return BlocPresentationListener<
      QuizTakingBloc,
      QuizTakingPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case QuizTakingNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocListener<QuizTakingBloc, QuizTakingState>(
        listenWhen: (prev, curr) =>
            prev.isSuccess != curr.isSuccess || prev.result != curr.result,
        listener: (context, state) {
          if (state.isSuccess && state.result != null) {
            QuizResultRoute(attemptId: state.result!.id).go(context);
          }
        },
        child: QuizTakingPage(
          isLoading: isLoading,
          isSubmitting: isSubmitting,
          errorMessage: errorMessage,
          quiz: quiz,
          questions: questions,
          currentQuestionIndex: currentQuestionIndex,
          answers: answers,
          remainingSeconds: remainingSeconds,
          quizId: quizId,
          attemptId: attemptId,
          onRetry: () {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(const QuizTakingLoadEvent());
          },
          onSubmit: () {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(const QuizTakingSubmit());
          },
          onPrevious: () {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(const QuizTakingPreviousQuestion());
          },
          onNext: () {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(const QuizTakingNextQuestion());
          },
          onJumpToQuestion: (index) {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(QuizTakingJumpToQuestion(index));
          },
          onAnswerSelected: (qId, val) {
            final bloc = context.read<QuizTakingBloc>();
            bloc.add(QuizTakingAnswerSelected(
              questionId: qId,
              selectedAnswer: val,
            ));
          },
          onReview: attemptId != null
              ? () async {
                  final targetIndex = await QuizReviewRoute(
                    quizId: quizId,
                    attemptId: attemptId,
                    $extra: answers,
                  ).push<int>(context);
                  if (targetIndex != null && context.mounted) {
                    final bloc = context.read<QuizTakingBloc>();
                    bloc.add(QuizTakingJumpToQuestion(targetIndex));
                  }
                }
              : null,
        ),
      ),
    );
  }
}
