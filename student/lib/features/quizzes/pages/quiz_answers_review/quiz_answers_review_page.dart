import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class QuizAnswersReviewPage extends StatelessWidget {
  const QuizAnswersReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    // Mock data for UI demonstration
    final answers = List.generate(
      10,
      (i) => (
        i % 3 != 0, // isCorrect
        isAr
            ? '${i + 1}. \u0645\u0627 \u0647\u064A \u0648\u062D\u062F\u0629 \u0642\u064A\u0627\u0633 \u0627\u0644\u062A\u0631\u062F\u062F\u061F'
            : '${i + 1}. What is the unit of frequency?',
        'Option ${i % 2 == 0 ? "A" : "B"}', // userAnswer
        'Option A', // correctAnswer
      ),
    );

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          const _BuildHeader(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              itemCount: answers.length,
              itemBuilder: (context, i) {
                final (isCorrect, question, userAnswer, correctAnswer) =
                    answers[i];
                return FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 50 * i),
                  child: _AnswerReviewCard(
                    question: question,
                    userAnswer: userAnswer,
                    correctAnswer: correctAnswer,
                    isCorrect: isCorrect,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  const _BuildHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          child: Column(
            children: [
              Row(
                children: [
                  MentorXIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.arrow_back_ios_new_rounded,
                    variant: MentorXIconButtonVariant.outline,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Spacer(),
                  Text(
                    context.t.quizzes.reviewAnswers,
                    style: context.titleH3Style.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  const Gap(48),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _AnswerReviewCard extends StatelessWidget {
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const _AnswerReviewCard({
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final statusColor = isCorrect
        ? context.statusSuccessColor
        : context.statusDangerColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MentorXGlassCard(
        style: Style(
          $box.padding.all(20),
          $box.borderRadius(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    isCorrect ? Icons.check_rounded : Icons.close_rounded,
                    size: 18,
                    color: statusColor,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Text(
                    question,
                    style: context.bodyPrimaryStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.5,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(24),
            _InfoTile(
              label: t.quizzes.yourAnswer,
              value: userAnswer,
              icon: isCorrect
                  ? Icons.check_circle_rounded
                  : Icons.cancel_rounded,
              color: statusColor,
            ),
            if (!isCorrect) ...[
              const Gap(12),
              _InfoTile(
                label: t.quizzes.correctAnswer,
                value: correctAnswer,
                icon: Icons.check_circle_rounded,
                color: context.statusSuccessColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

final class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: context.textSecondaryColor,
                    letterSpacing: 1.0,
                  ),
                ),
                const Gap(4),
                Text(
                  value,
                  style: context.bodyPrimaryStyle.copyWith(
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
