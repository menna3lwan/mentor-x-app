import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:flutter/services.dart';
import 'bloc/quiz_result_page_bloc.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocBuilder<QuizResultPageBloc, QuizResultPageState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger.withValues(alpha: 0.5)),
                    ),
                    const Gap(24),
                    FadeInUp(
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: palette.textSecondary),
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: MentorXButton(
                        label: t['commonBack']!,
                        onPressed: () => context.go('/'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final result = state.result;
        if (result == null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(child: Text(t['resultNotFound'] ?? 'Result not found')),
          );
        }

        final total = result.totalMarks;
        final correct = result.score;
        final wrong = total - correct;
        final minutes = result.timeSpentSeconds ~/ 60;
        final seconds = result.timeSpentSeconds % 60;
        final timeTaken = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        final percent = result.percentage / 100;

        final resultLabel = percent >= 0.85
            ? t['excellent']!
            : (percent >= 0.60 ? t['veryGood']! : t['fail']!);

        final statusColor = percent >= 0.60 ? palette.statusSuccess : palette.statusDanger;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: palette.brandPrimary,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Column(
              children: [
                _BuildHeader(palette: palette, t: t),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                    child: Column(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          child: _BuildResultCircle(
                            percent: percent,
                            correct: correct,
                            total: total,
                            label: resultLabel,
                            color: statusColor,
                            palette: palette,
                            t: t,
                          ),
                        ),
                        const Gap(32),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            percent >= 0.60 ? t['greatResult']! : (t['betterLuckNextTime'] ?? 'Better luck next time!'),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: palette.textPrimary,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(8),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 300),
                          child: Text(
                            '${(percent * 100).toInt()}% - $resultLabel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: palette.textTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(32),
                        Row(
                          children: [
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 400),
                                child: _StatBox(
                                  value: '$correct',
                                  label: t['correctAnswers']!,
                                  color: palette.statusSuccess,
                                  palette: palette,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 500),
                                child: _StatBox(
                                  value: '$wrong',
                                  label: t['wrongAnswers']!,
                                  color: palette.statusDanger,
                                  palette: palette,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 600),
                                child: _StatBox(
                                  value: timeTaken,
                                  label: t['timeTaken']!,
                                  color: palette.brandSecondary,
                                  palette: palette,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(40),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 700),
                          child: _BuildLeaderboard(
                            leaderboard: state.leaderboard,
                            myRank: state.myRank,
                            palette: palette,
                            t: t,
                          ),
                        ),
                        const Gap(40),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 800),
                          child: MentorXButton(
                            label: t['reviewAnswers']!,
                            onPressed: () => context.push('/quiz-answers-review', extra: result),
                          ),
                        ),
                        if (percent >= 0.85) ...[
                          const Gap(12),
                          FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 900),
                            child: MentorXButton(
                              label: t['claimReward']!,
                              onPressed: () => context.push('/quiz-rewards', extra: result),
                            ),
                          ),
                        ],
                        const Gap(24),
                        FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 1000),
                          child: TextButton(
                            onPressed: () => context.go('/'),
                            child: Text(
                              t['commonBack']!,
                              style: TextStyle(
                                color: palette.textTertiary,
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
      },
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildHeader({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          t['quizResult'] ?? 'Quiz Result',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}

class _BuildResultCircle extends StatelessWidget {
  final double percent;
  final int correct;
  final int total;
  final String label;
  final Color color;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildResultCircle({
    required this.percent,
    required this.correct,
    required this.total,
    required this.label,
    required this.color,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percent),
      duration: const Duration(milliseconds: 2000),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2 * (value / percent).clamp(0, 1)),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 190,
                height: 190,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 14,
                  backgroundColor: palette.backgroundSecondary,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(value * total).toInt()} / $total',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    t['score'] ?? 'Score',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: palette.textTertiary,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildLeaderboard extends StatelessWidget {
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildLeaderboard({
    required this.leaderboard,
    this.myRank,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    if (leaderboard.isEmpty && myRank == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_events_outlined, color: palette.brandSecondary, size: 24),
            const Gap(8),
            Text(
              t['leaderboard'] ?? 'Leaderboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const Gap(16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              ...leaderboard.take(3).map((entry) => _LeaderboardTile(
                    entry: entry,
                    palette: palette,
                  )),
              if (myRank != null && leaderboard.indexWhere((e) => e.studentId == myRank!.studentId) >= 3) ...[
                const Divider(height: 1, indent: 24, endIndent: 24),
                _LeaderboardTile(
                  entry: myRank!,
                  palette: palette,
                  isHighlighted: true,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntryEntity entry;
  final MentorXThemeColorPalette palette;
  final bool isHighlighted;

  const _LeaderboardTile({
    required this.entry,
    required this.palette,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = entry.rank == 1
        ? const Color(0xFFFFD700)
        : (entry.rank == 2 ? const Color(0xFFC0C0C0) : (entry.rank == 3 ? const Color(0xFFCD7F32) : palette.brandSecondary));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isHighlighted ? palette.brandPrimary.withValues(alpha: 0.05) : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${entry.rank}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              entry.studentName,
              style: TextStyle(
                color: palette.textPrimary,
                fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            '${entry.score}%',
            style: TextStyle(
              color: palette.brandPrimary,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final MentorXThemeColorPalette palette;

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: palette.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
