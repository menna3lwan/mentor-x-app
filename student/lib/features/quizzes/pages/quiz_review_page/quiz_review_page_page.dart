import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';

final class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    // Mock data for UI demonstration
    const timerText = '24:35';
    final answered = List.generate(16, (i) => i);
    const total = 20;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t, timerText: timerText),
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
                      answeredCount: answered.length,
                      totalCount: total,
                    ),
                  ),
                  const Gap(40),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      t['jumpToQuestion'] ?? 'Jump to Question',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
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
                        final isAnswered = answered.contains(i);
                        return _QuestionStatusBox(
                          index: i + 1,
                          isAnswered: isAnswered,
                        );
                      },
                    ),
                  ),
                  const Gap(48),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: MentorXButton(
                      onPressed: () => context.push('/quiz-result'),
                      label: t['submitQuiz'] ?? 'Submit Quiz',
                    ),
                  ),
                  const Gap(16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity,
                      child: MentorXButton(
                        onPressed: () => Navigator.pop(context),
                        label: t['backToQuestions'] ?? 'Back to Questions',
                        color: context.backgroundPrimaryColor,
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
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              t['reviewAnswers'] ?? 'Review Answers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
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
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t['answeredCount'] ?? 'Answered Questions',
            style: TextStyle(
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
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: context.brandPrimaryColor,
                  letterSpacing: -1,
                ),
              ),
              Text(
                ' / $totalCount',
                style: TextStyle(
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
                    t['unansweredNote']?.replaceAll('%s', '$unansweredCount') ??
                        '$unansweredCount questions left',
                    style: TextStyle(
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
    return Container(
      decoration: BoxDecoration(
        color: isAnswered
            ? context.brandPrimaryColor
            : context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAnswered
              ? context.brandPrimaryColor
              : context.borderPrimaryColor.withValues(alpha: 0.05),
          width: 2,
        ),
        boxShadow: isAnswered
            ? [
                BoxShadow(
                  color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: isAnswered ? Colors.white : context.textTertiaryColor,
          ),
        ),
      ),
    );
  }
}
