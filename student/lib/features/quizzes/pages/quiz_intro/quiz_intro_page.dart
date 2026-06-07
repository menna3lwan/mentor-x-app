import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class QuizIntroPage extends StatelessWidget {
  final LoadingState loadingState;
  final String? errorMessage;
  final QuizEntity? quiz;
  final QuizAttemptEntity? activeAttempt;
  final VoidCallback onRetry;
  final VoidCallback onStartResume;

  const QuizIntroPage({
    super.key,
    required this.loadingState,
    this.errorMessage,
    this.quiz,
    this.activeAttempt,
    required this.onRetry,
    required this.onStartResume,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;

    if (loadingState == LoadingState.loading) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            const MentorXSkeleton(height: 250, borderRadius: 32),
            const Gap(32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const MentorXSkeleton(height: 300, borderRadius: 32),
                    const Gap(32),
                    const MentorXSkeleton(height: 56, borderRadius: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: AppErrorView(
          message: errorMessage!,
          onRetry: onRetry,
        ),
      );
    }

    if (quiz == null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: AppEmptyView(
          title: t.quizNotFound,
          message: 'Try again later',
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            _BuildHeader(quiz: quiz!),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      child: _BuildContentCard(quiz: quiz!),
                    ),
                    const Gap(32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                      child: MentorXButton(
                        label:
                            activeAttempt != null &&
                                activeAttempt!.status ==
                                    QuizAttemptStatus.inProgress
                            ? t.resumeQuiz
                            : t.startQuiz,
                        onPressed: onStartResume,
                        size: MentorXButtonSize.large,
                      ),
                    ),
                    const Gap(16),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 500),
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          t.commonBack,
                          style: context.bodySecondaryStyle.copyWith(
                            color: context.textTertiaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final QuizEntity quiz;
  const _BuildHeader({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        32,
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
                    onPressed: () => context.pop(),
                    icon: Icons.arrow_back_ios_new_rounded,
                    variant: MentorXIconButtonVariant.outline,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Spacer(),
                  Text(
                    context.t.quizzes.quizUnitTitle,
                    style: context.titleH3Style.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  const Gap(48),
                ],
              ),
              const Gap(24),
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.brandPrimaryColor.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.fact_check_rounded,
                    size: 40,
                    color: context.brandPrimaryColor,
                  ),
                ),
              ),
              const Gap(24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    quiz.title,
                    textAlign: TextAlign.center,
                    style: context.titleH2Style.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    quiz.description ?? context.t.quizzes.quizSubtitle,
                    textAlign: TextAlign.center,
                    style: context.bodySecondaryStyle.copyWith(
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _BuildContentCard extends StatelessWidget {
  final QuizEntity quiz;
  const _BuildContentCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(24),
        $box.borderRadius(32),
      ),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.1,
            children: [
              _InfoItem(
                value: '${quiz.questionsCount ?? quiz.questions.length}',
                label: t.questionCount,
                icon: Icons.help_outline_rounded,
              ),
              _InfoItem(
                value: '${quiz.durationMinutes} ${t.minutesShort}',
                label: t.duration,
                icon: Icons.access_time_rounded,
              ),
              _InfoItem(
                value: '${quiz.passMarks} / ${quiz.totalMarks}',
                label: t.passGrade,
                icon: Icons.grade_rounded,
              ),
              _InfoItem(
                value: '1',
                label: t.attempts,
                icon: Icons.refresh_rounded,
              ),
            ],
          ),
          const Gap(32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      t.instructions,
                      style: context.bodyPrimaryStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                _InstructionLine(text: t.instructionRead),
                const Gap(12),
                _InstructionLine(text: t.instructionReview),
                const Gap(12),
                _InstructionLine(text: t.instructionNoReturn),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _InstructionLine extends StatelessWidget {
  final String text;

  const _InstructionLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 12,
              color: context.textSecondaryColor,
              height: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

final class _InfoItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _InfoItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.brandPrimaryColor.withValues(alpha: 0.6),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: context.textTertiaryColor,
                    letterSpacing: 0.2,
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
