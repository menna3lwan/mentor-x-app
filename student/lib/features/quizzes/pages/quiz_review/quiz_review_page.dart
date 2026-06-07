import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class QuizReviewPage extends StatelessWidget {
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final List<QuizQuestionEntity> questions;
  final Map<String, String> answers;
  final VoidCallback onRetry;
  final VoidCallback onSubmit;

  const QuizReviewPage({
    super.key,
    required this.isLoading,
    required this.isSubmitting,
    required this.errorMessage,
    required this.questions,
    required this.answers,
    required this.onRetry,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: AppErrorView(
          message: errorMessage!,
          onRetry: onRetry,
        ),
      );
    }

    final total = questions.length;
    final answeredCount = questions
        .where((q) => answers[q.id]?.isNotEmpty == true)
        .length;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t, timerText: '--:--'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: _BuildProgressOverview(
                      t: t,
                      answeredCount: answeredCount,
                      totalCount: total,
                    ),
                  ),
                  const Gap(40),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      t.review.jumpToQuestion,
                      style: context.bodyPrimaryStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const Gap(20),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                      itemCount: total,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        final question = questions[i];
                        final isAnswered =
                            answers[question.id]?.isNotEmpty == true;
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pop(i),
                          child: _QuestionStatusBox(
                            index: i + 1,
                            isAnswered: isAnswered,
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(48),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: MentorXButton(
                      loading: isSubmitting,
                      onPressed: onSubmit,
                      label: t.review.submitQuiz,
                      size: MentorXButtonSize.large,
                    ),
                  ),
                  const Gap(16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity,
                      child: MentorXButton(
                        onPressed: () => context.pop(),
                        label: t.review.backToQuestions,
                        variant: MentorXButtonVariant.outline,
                        size: MentorXButtonSize.large,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;
  final String timerText;

  const _BuildHeader({
    required this.t,
    required this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => context.pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              Expanded(
                child: Text(
                  t.review.title,
                  textAlign: TextAlign.center,
                  style: context.titleH3Style.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: context.brandPrimaryColor,
                      size: 14,
                    ),
                    const Gap(6),
                    Text(
                      timerText,
                      style: context.bodySecondaryStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _BuildProgressOverview extends StatelessWidget {
  final dynamic t;
  final int answeredCount;
  final int totalCount;

  const _BuildProgressOverview({
    required this.t,
    required this.answeredCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final unansweredCount = totalCount - answeredCount;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(24),
        $box.borderRadius(28),
      ),
      child: Column(
        children: [
          Text(
            t.review.answeredCount,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: context.textTertiaryColor,
              letterSpacing: -0.2,
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$answeredCount',
                style: context.titleH1Style.copyWith(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: context.brandPrimaryColor,
                  letterSpacing: -1,
                ),
              ),
              Text(
                ' / $totalCount',
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: context.textTertiaryColor.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          if (unansweredCount > 0) ...[
            const Gap(24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: context.statusWarningColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.statusWarningColor.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: context.statusWarningColor,
                  ),
                  const Gap(10),
                  Text(
                    t.review.unansweredNote(count: unansweredCount.toString()),
                    style: context.bodySecondaryStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: context.statusWarningColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

final class _QuestionStatusBox extends StatelessWidget {
  final int index;
  final bool isAnswered;

  const _QuestionStatusBox({
    required this.index,
    required this.isAnswered,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius(16),
        isAnswered
            ? $box.color(context.brandPrimaryColor)
            : $box.color(context.backgroundPrimaryColor.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          '$index',
          style: context.bodyPrimaryStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: isAnswered ? Colors.white : context.textTertiaryColor,
          ),
        ),
      ),
    );
  }
}
