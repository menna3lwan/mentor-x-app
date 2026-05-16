import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/quiz_list_page_bloc.dart';

final class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          const _BuildHeader(),
          Expanded(
            child: Builder(
              builder: (context) {
                final loadingState = context
                    .select<QuizListPageBloc, LoadingState>(
                      (bloc) => bloc.state.loadingState,
                    );
                final quizzes = context
                    .select<QuizListPageBloc, List<QuizEntity>>(
                      (bloc) => bloc.state.quizzes,
                    );

                if (loadingState == LoadingState.loading) {
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                    itemCount: 6,
                    separatorBuilder: (_, _) => const Gap(16),
                    itemBuilder: (_, _) => const MentorXSkeleton(
                      height: 110,
                      borderRadius: 28,
                    ),
                  );
                }

                if (quizzes.isEmpty) {
                  return AppEmptyView(
                    title: t.noQuizzes,
                    message: t.noQuizzesDesc,
                    icon: Icons.assignment_turned_in_rounded,
                  );
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                  itemCount: quizzes.length,
                  separatorBuilder: (_, _) => const Gap(16),
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    return FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 100 * index),
                      child: _QuizItemCard(
                        quiz: quiz,
                        onTap: () {
                          QuizIntroPageRoute(
                            quizId: quiz.id,
                          ).push(context);
                        },
                      ),
                    );
                  },
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
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.quizzes.assessments.toUpperCase(),
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      context.t.quizzes.navQuizzes,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
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

final class _QuizItemCard extends StatelessWidget {
  final QuizEntity quiz;
  final VoidCallback onTap;

  const _QuizItemCard({
    required this.quiz,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MentorXGlassCard(
        style: Style(
          $box.padding.all(18),
          $box.borderRadius(28),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: context.brandSecondaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: context.brandSecondaryColor.withValues(alpha: 0.2),
                ),
              ),
              child: Hero(
                tag: 'quiz_icon_${quiz.id}',
                child: Icon(
                  Icons.quiz_rounded,
                  size: 26,
                  color: context.brandSecondaryColor,
                ),
              ),
            ),
            const Gap(18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyPrimaryStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      _QuizInfoLabel(
                        icon: Icons.help_outline_rounded,
                        label:
                            '${quiz.questionsCount ?? 0} ${context.t.quizzes.questions}',
                      ),
                      const Gap(16),
                      _QuizInfoLabel(
                        icon: Icons.access_time_rounded,
                        label:
                            '${quiz.durationMinutes} ${context.t.quizzes.minutesShort}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: context.textTertiaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _QuizInfoLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuizInfoLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: context.textTertiaryColor,
        ),
        const Gap(4),
        Text(
          label,
          style: context.bodySecondaryStyle.copyWith(
            fontSize: 12,
            color: context.textTertiaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
