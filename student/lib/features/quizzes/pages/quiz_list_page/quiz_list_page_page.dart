import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

    return Builder(
      builder: (context) {
        final loadingState = context.select<QuizListPageBloc, LoadingState>(
          (bloc) => bloc.state.loadingState,
        );
        final quizzes = context.select<QuizListPageBloc, List<dynamic>>(
          (bloc) => bloc.state.quizzes,
        );

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Stack(
            children: [
              const _BackgroundDecorations(),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120,
                    collapsedHeight: 80,
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    flexibleSpace: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            t['navQuizzes']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              color: context.backgroundSecondaryColor
                                  .withValues(alpha: 0.45),
                              border: Border(
                                bottom: BorderSide(
                                  color: context.borderPrimaryColor
                                      .withValues(alpha: 0.1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildBody(context, loadingState, quizzes, t),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    LoadingState loadingState,
    List<dynamic> quizzes,
    dynamic t,
  ) {
    if (loadingState == LoadingState.loading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (quizzes.isEmpty) {
      return SliverFillRemaining(
        child: FadeInUp(
          child: _EmptyQuizzes(t: t),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final quiz = quizzes[index];
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 100 * index),
              child: _QuizItemCard(
                quiz: quiz,
                t: t,
                onTap: () {
                  context.push('/quiz-intro');
                },
              ),
            );
          },
          childCount: quizzes.length,
        ),
      ),
    );
  }
}

final class _QuizItemCard extends StatelessWidget {
  final dynamic quiz;
  final dynamic t;
  final VoidCallback onTap;

  const _QuizItemCard({
    required this.quiz,
    required this.t,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.brandPrimaryColor.withValues(alpha: 0.15),
                            context.brandPrimaryColor.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Icon(
                        Icons.quiz_rounded,
                        size: 26,
                        color: context.brandPrimaryColor,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const Gap(6),
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
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: context.textTertiaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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

final class _EmptyQuizzes extends StatelessWidget {
  const _EmptyQuizzes({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.borderPrimaryColor.withValues(alpha: 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        context.textTertiaryColor.withValues(alpha: 0.3),
                        context.textTertiaryColor.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.assignment_turned_in_rounded,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(40),
            Text(
              t['noQuizzes'] ?? 'No quizzes available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(16),
            Text(
              t['noQuizzesDesc'] ?? 'Check back later for new quizzes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
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
