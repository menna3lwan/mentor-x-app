import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:flutter/services.dart';

final class QuizResultPagePage extends StatelessWidget {
  final LoadingState loadingState;
  final String? errorMessage;
  final QuizAttemptEntity? result;
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;
  final VoidCallback onRetry;

  const QuizResultPagePage({
    super.key,
    required this.loadingState,
    this.errorMessage,
    this.result,
    required this.leaderboard,
    this.myRank,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    if (loadingState == LoadingState.loading) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            const MentorXSkeleton(height: 120, borderRadius: 32),
            const Gap(32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Center(
                      child: MentorXSkeleton(
                        height: 220,
                        width: 220,
                        borderRadius: 110,
                      ),
                    ),
                    const Gap(40),
                    const MentorXSkeleton(height: 40, borderRadius: 12),
                    const Gap(12),
                    const MentorXSkeleton(height: 20, borderRadius: 12),
                    const Gap(40),
                    Row(
                      children: List.generate(
                        3,
                        (index) => const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: MentorXSkeleton(height: 100, borderRadius: 24),
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

    if (result == null) {
      return Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: AppEmptyView(
          title: t['resultNotFound'] ?? 'Result not found',
          message: 'Try again later',
        ),
      );
    }

    final total = result!.totalMarks;
    final correct = result!.score;
    final wrong = total - correct;
    final minutes = result!.timeSpentSeconds ~/ 60;
    final seconds = result!.timeSpentSeconds % 60;
    final timeTaken =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final percent = result!.percentage / 100;

    final resultLabel = percent >= 0.85
        ? t['excellent']!
        : (percent >= 0.60 ? t['veryGood']! : t['fail']!);

    final statusColor = percent >= 0.60
        ? context.statusSuccessColor
        : context.statusDangerColor;

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
                _BuildHeader(t: t),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                    child: Column(
                      children: [
                        FadeInDown(
                          key: const ValueKey('quiz_result_circle_fade'),
                          duration: const Duration(milliseconds: 800),
                          child: _BuildResultCircle(
                            percent: percent,
                            correct: correct,
                            total: total,
                            label: resultLabel,
                            color: statusColor,
                            t: t,
                          ),
                        ),
                        const Gap(40),
                        FadeInUp(
                          key: const ValueKey('quiz_result_congrats_fade'),
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            percent >= 0.60
                                ? t['greatResult']!
                                : (t['betterLuckNextTime'] ??
                                    'Better luck next time!'),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(8),
                        FadeInUp(
                          key: const ValueKey('quiz_result_score_text_fade'),
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 300),
                          child: Text(
                            '${(percent * 100).toInt()}% - $resultLabel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: context.textTertiaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(40),
                        Row(
                          children: [
                            Expanded(
                              child: FadeInUp(
                                key: const ValueKey('quiz_result_stat_correct_fade'),
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 400),
                                child: _StatBox(
                                  value: '$correct',
                                  label: t['correctAnswers']!,
                                  color: context.statusSuccessColor,
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: FadeInUp(
                                key: const ValueKey('quiz_result_stat_wrong_fade'),
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 500),
                                child: _StatBox(
                                  value: '$wrong',
                                  label: t['wrongAnswers']!,
                                  color: context.statusDangerColor,
                                ),
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: FadeInUp(
                                key: const ValueKey('quiz_result_stat_time_fade'),
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 600),
                                child: _StatBox(
                                  value: timeTaken,
                                  label: t['timeTaken']!,
                                  color: context.brandSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(40),
                        FadeInUp(
                          key: const ValueKey('quiz_result_leaderboard_fade'),
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 700),
                          child: _BuildLeaderboard(
                            leaderboard: leaderboard,
                            myRank: myRank,
                            t: t,
                          ),
                        ),
                        const Gap(40),
                        FadeInUp(
                          key: const ValueKey('quiz_result_review_btn_fade'),
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 800),
                          child: MentorXButton(
                            label: t['reviewAnswers']!,
                            onPressed: () => context.push(
                              '/quiz-answers-review',
                              extra: result,
                            ),
                          ),
                        ),
                        if (percent >= 0.85) ...[
                          const Gap(12),
                          FadeInUp(
                            key: const ValueKey('quiz_result_claim_btn_fade'),
                            duration: const Duration(milliseconds: 600),
                            delay: const Duration(milliseconds: 900),
                            child: MentorXButton(
                              label: t['claimReward']!,
                              color: context.backgroundPrimaryColor,
                              onPressed: () => context.push('/quiz-rewards',
                                  extra: result),
                            ),
                          ),
                        ],
                        const Gap(24),
                        FadeInUp(
                          key: const ValueKey('quiz_result_back_btn_fade'),
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 1000),
                          child: TextButton(
                            onPressed: () => context.go('/'),
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
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
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
          child: Center(
            child: Text(
              t['quizResult'] ?? 'Quiz Result',
              style: TextStyle(
                color: context.textPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _BuildResultCircle extends StatelessWidget {
  final double percent;
  final int correct;
  final int total;
  final String label;
  final Color color;
  final dynamic t;

  const _BuildResultCircle({
    required this.percent,
    required this.correct,
    required this.total,
    required this.label,
    required this.color,
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
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(
                  alpha: 0.2 * (value / percent).clamp(0, 1),
                ),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 14,
                      backgroundColor:
                          context.backgroundPrimaryColor.withValues(alpha: 0.5),
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
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -1,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        t['score'] ?? 'Score',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: context.textTertiaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final class _BuildLeaderboard extends StatelessWidget {
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;
  final dynamic t;

  const _BuildLeaderboard({
    required this.leaderboard,
    this.myRank,
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
            Icon(
              Icons.emoji_events_outlined,
              color: context.brandSecondaryColor,
              size: 24,
            ),
            const Gap(10),
            Text(
              t['leaderboard'] ?? 'Leaderboard',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const Gap(16),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  ...leaderboard.take(3).map(
                        (entry) => _LeaderboardTile(
                          entry: entry,
                        ),
                      ),
                  if (myRank != null &&
                      leaderboard.indexWhere(
                            (e) => e.studentId == myRank!.studentId,
                          ) >=
                          3) ...[
                    const Divider(
                      height: 1,
                      indent: 24,
                      endIndent: 24,
                      color: Color(0x0DFFFFFF),
                    ),
                    _LeaderboardTile(
                      entry: myRank!,
                      isHighlighted: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntryEntity entry;
  final bool isHighlighted;

  const _LeaderboardTile({
    required this.entry,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = entry.rank == 1
        ? const Color(0xFFFFD700)
        : (entry.rank == 2
            ? const Color(0xFFC0C0C0)
            : (entry.rank == 3
                ? const Color(0xFFCD7F32)
                : context.brandSecondaryColor));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isHighlighted
            ? context.brandPrimaryColor.withValues(alpha: 0.1)
            : null,
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
              border: Border.all(color: color.withValues(alpha: 0.2)),
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
          const Gap(16),
          Expanded(
            child: Text(
              entry.studentName,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.w800,
                fontSize: 15,
                letterSpacing: -0.2,
              ),
            ),
          ),
          Text(
            '${entry.score}%',
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

final class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: color,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
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
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
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
