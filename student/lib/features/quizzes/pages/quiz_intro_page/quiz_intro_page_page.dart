import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro_page/bloc/quiz_intro_page_bloc.dart';

final class QuizIntroPage extends StatelessWidget {
  const QuizIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return BlocBuilder<QuizIntroPageBloc, QuizIntroPageState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
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

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppErrorView(
              message: state.errorMessage!,
              onRetry: () => context.read<QuizIntroPageBloc>().add(
                    const QuizIntroPageLoadEvent(),
                  ),
            ),
          );
        }

        final quiz = state.quiz;
        if (quiz == null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppEmptyView(
              title: t['quizNotFound'] ?? 'Quiz not found',
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
            body: Stack(
              children: [
                const _BackgroundDecorations(),
                Column(
                  children: [
                    _BuildHeader(quiz: quiz),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 200),
                              child: _BuildContentCard(quiz: quiz),
                            ),
                            const Gap(32),
                            FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 400),
                              child: MentorXButton(
                                label: state.activeAttempt != null &&
                                        state.activeAttempt!.status ==
                                            QuizAttemptStatus.inProgress
                                    ? t['resumeQuiz'] ?? 'Resume Quiz'
                                    : t['startQuiz']!,
                                onPressed: () => QuizTakingPageRoute(
                                  quizId: quiz.id,
                                ).push(context),
                              ),
                            ),

                            const Gap(16),
                            FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 500),
                              child: TextButton(
                                onPressed: () => context.pop(),
                                child: Text(
                                  t['commonBack']!,
                                  style: TextStyle(
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
              ],
            ),
          ),
        );
      },
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
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        32,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              Row(
                children: [
                  MentorXIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.arrow_back_ios_new_rounded,
                    color: context.textPrimaryColor,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Spacer(),
                  Text(
                    context.t.student['quizUnitTitle'] ?? 'Unit Quiz',
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
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
                    boxShadow: [
                      BoxShadow(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        blurRadius: 20,
                      ),
                    ],
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
                child: Text(
                  quiz.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const Gap(8),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: Text(
                  quiz.description ??
                      context.t.student['quizSubtitle'] ??
                      'Test your knowledge of this unit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textTertiaryColor,
                    fontWeight: FontWeight.w700,
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
    final t = context.t.student;

    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.0,
                  children: [
                    _InfoItem(
                      value: '${quiz.questionsCount ?? quiz.questions.length}',
                      label: t['questionCount']!,
                      icon: Icons.help_outline_rounded,
                    ),
                    _InfoItem(
                      value: '${quiz.durationMinutes} ${t['minutesShort']!}',
                      label: t['duration']!,
                      icon: Icons.access_time_rounded,
                    ),
                    _InfoItem(
                      value: '${quiz.passMarks} / ${quiz.totalMarks}',
                      label: t['passGrade']!,
                      icon: Icons.grade_rounded,
                    ),
                    _InfoItem(
                      value: '1', // Hardcoded attempts for now as QuizEntity doesn't seem to have it
                      label: t['attempts']!,
                      icon: Icons.refresh_rounded,
                    ),
                  ],
                ),
                const Gap(32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
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
                            t['instructions'] ?? 'Instructions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      _InstructionLine(text: t['instructionRead']!),
                      const Gap(12),
                      _InstructionLine(text: t['instructionReview']!),
                      const Gap(12),
                      _InstructionLine(text: t['instructionNoReturn']!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
            style: TextStyle(
              fontSize: 14,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: context.brandPrimaryColor.withValues(alpha: 0.6),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
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
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
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
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
