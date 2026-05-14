import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/quiz_list_page_bloc.dart';

final class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              _BuildHeader(t: t),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final loadingState = context.select<QuizListPageBloc, LoadingState>(
                      (bloc) => bloc.state.loadingState,
                    );
                    final quizzes = context.select<QuizListPageBloc, List<QuizEntity>>(
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
                        title: t['noQuizzes'] ?? 'No quizzes available',
                        message: t['noQuizzesDesc'] ?? 'Check back later for new quizzes.',
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
                            t: t,
                            onTap: () {
                              QuizIntroPageRoute(quizId: quiz.id).push(context);
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
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
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
              Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: MentorXIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: MentorXIconButtonSize.small,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ASSESSMENTS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t['navQuizzes']!,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 22,
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
  final Map<String, dynamic> t;
  final VoidCallback onTap;

  const _QuizItemCard({
    required this.quiz,
    required this.t,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.brandSecondaryColor.withValues(alpha: 0.2),
                    context.brandSecondaryColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      _QuizInfoLabel(
                        icon: Icons.help_outline_rounded,
                        label: '${quiz.questionsCount ?? 0} ${t['questions']!}',
                      ),
                      const Gap(16),
                      _QuizInfoLabel(
                        icon: Icons.access_time_rounded,
                        label: '${quiz.durationMinutes} ${t['minutesShort']!}',
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
          style: TextStyle(
            fontSize: 12,
            color: context.textTertiaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 350,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
      ),
    );
  }
}
