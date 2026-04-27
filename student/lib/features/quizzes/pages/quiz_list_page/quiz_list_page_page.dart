import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/quiz_list_page_bloc.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<QuizListPageBloc, QuizListPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4)),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['navQuizzes']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                ),
              ),
            ),
          ),
          body: _buildBody(context, state, palette, t),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    QuizListPageState state,
    MentorXThemeColorPalette palette,
    dynamic t,
  ) {
    if (state.loadingState == LoadingState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.quizzes.isEmpty) {
      return FadeInUp(child: _EmptyQuizzes(t: t, palette: palette));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      itemCount: state.quizzes.length,
      itemBuilder: (context, index) {
        final quiz = state.quizzes[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: _QuizItemCard(
            quiz: quiz,
            palette: palette,
            t: t,
            onTap: () {
              context.push('/quiz-intro'); 
            },
          ),
        );
      },
    );
  }
}

class _QuizItemCard extends StatelessWidget {
  final QuizEntity quiz;
  final MentorXThemeColorPalette palette;
  final dynamic t;
  final VoidCallback onTap;

  const _QuizItemCard({
    required this.quiz,
    required this.palette,
    required this.t,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: palette.brandPrimary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.quiz_rounded, size: 28, color: palette.brandPrimary),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: palette.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Icon(Icons.help_outline_rounded, size: 12, color: palette.textTertiary),
                          const Gap(4),
                          Text(
                            '${quiz.questionsCount ?? 0} ${t['questions']!}',
                            style: TextStyle(fontSize: 11, color: palette.textTertiary, fontWeight: FontWeight.w700),
                          ),
                          const Gap(12),
                          Icon(Icons.access_time_rounded, size: 12, color: palette.textTertiary),
                          const Gap(4),
                          Text(
                            '${quiz.durationMinutes} ${t['minutesShort']!}',
                            style: TextStyle(fontSize: 11, color: palette.textTertiary, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: palette.textTertiary.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyQuizzes extends StatelessWidget {
  const _EmptyQuizzes({required this.t, required this.palette});
  final dynamic t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
              ],
            ),
            child: Icon(
              Icons.assignment_turned_in_rounded,
              size: 80,
              color: palette.textTertiary.withValues(alpha: 0.2),
            ),
          ),
          const Gap(32),
          Text(
            t['noQuizzes'] ?? 'No quizzes available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
            ),
          ),
          const Gap(10),
          Text(
            t['noQuizzesDesc'] ?? 'Check back later for new quizzes.',
            style: TextStyle(
              fontSize: 15,
              color: palette.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
