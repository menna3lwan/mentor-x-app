import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
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
    final t = context.t.quizzes;

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
                            child: MentorXSkeleton(
                              height: 100,
                              borderRadius: 24,
                            ),
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
          title: t.resultNotFound,
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
        ? t.excellent
        : (percent >= 0.60 ? t.veryGood : t.fail);

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
        body: Column(
          children: [
            const _BuildHeader(),
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
                      ),
                    ),
                    const Gap(40),
                    FadeInUp(
                      key: const ValueKey('quiz_result_congrats_fade'),
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        percent >= 0.60 ? t.greatResult : t.fail,
                        style: context.titleH1Style.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
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
                        style: context.bodySecondaryStyle.copyWith(
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
                            key: const ValueKey(
                              'quiz_result_stat_correct_fade',
                            ),
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 400),
                            child: _StatBox(
                              value: '$correct',
                              label: t.correctAnswers,
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
                              label: t.wrongAnswers,
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
                              label: t.timeTaken,
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
                      ),
                    ),
                    const Gap(40),
                    FadeInUp(
                      key: const ValueKey('quiz_result_review_btn_fade'),
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 800),
                      child: MentorXButton(
                        label: t.reviewAnswers,
                        onPressed: () => context.push(
                          '/quiz-answers-review',
                          extra: result,
                        ),
                        size: MentorXButtonSize.large,
                      ),
                    ),
                    if (percent >= 0.85) ...[
                      const Gap(12),
                      FadeInUp(
                        key: const ValueKey('quiz_result_claim_btn_fade'),
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 900),
                        child: MentorXButton(
                          label: t.claimReward,
                          color: context.backgroundPrimaryColor,
                          onPressed: () =>
                              context.push('/quiz-rewards', extra: result),
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
                          t.commonBack, // Using commonBack as fallback
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

class _BuildHeader extends StatelessWidget {
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
                    onPressed: () => context.pop(),
                    icon: Icons.close_rounded,
                    variant: MentorXIconButtonVariant.outline,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Spacer(),
                  Text(
                    context.t.quizzes.quizResult,
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

class _BuildResultCircle extends StatelessWidget {
  final double percent;
  final int correct;
  final int total;
  final String label;
  final Color color;

  const _BuildResultCircle({
    required this.percent,
    required this.correct,
    required this.total,
    required this.label,
    required this.color,
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
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(
                  alpha: 0.15 * (value / percent).clamp(0, 1),
                ),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: MentorXGlassCard(
            style: Style(
              $box.color(
                context.backgroundSecondaryColor.withValues(alpha: 0.45),
              ),
              $box.borderRadius(110),
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
                    backgroundColor: context.backgroundPrimaryColor.withValues(
                      alpha: 0.5,
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(value * total).toInt()} / $total',
                      style: context.titleH1Style.copyWith(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        height: 1,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      context.t.quizzes.score,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 12,
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
        );
      },
    );
  }
}

class _BuildLeaderboard extends StatelessWidget {
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;

  const _BuildLeaderboard({
    required this.leaderboard,
    this.myRank,
  });

  @override
  Widget build(BuildContext context) {
    if (leaderboard.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.brandSecondaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.emoji_events_rounded,
                color: context.brandSecondaryColor,
                size: 20,
              ),
            ),
            const Gap(12),
            Text(
              context.t.quizzes.leaderboard,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const Gap(16),
        MentorXGlassCard(
          style: Style(
            $box.borderRadius(28),
            $box.padding.vertical(12),
          ),
          child: Column(
            children: [
              ...leaderboard
                  .take(3)
                  .map(
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
      ],
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isHighlighted
            ? context.brandPrimaryColor.withValues(alpha: 0.1)
            : null,
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
                style: context.bodySecondaryStyle.copyWith(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              entry.studentName,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: isHighlighted ? FontWeight.w900 : FontWeight.w800,
                letterSpacing: -0.2,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            '${entry.score}%',
            style: context.bodyPrimaryStyle.copyWith(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 14,
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

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius(24),
        $box.padding.vertical(20),
        $box.padding.horizontal(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.titleH2Style.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
              height: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: context.textTertiaryColor,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
