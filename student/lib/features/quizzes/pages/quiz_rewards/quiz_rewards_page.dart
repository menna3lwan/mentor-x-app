import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/quiz_rewards_page_bloc.dart';

final class QuizRewardsPage extends StatelessWidget {
  const QuizRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t),
          Expanded(
            child: Builder(
              builder: (context) {
                final loadingState = context.select(
                  (QuizRewardsPageBloc bloc) => bloc.state.loadingState,
                );

                if (loadingState == LoadingState.loading) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: 4,
                    separatorBuilder: (_, _) => const Gap(16),
                    itemBuilder: (_, _) => const MentorXSkeleton(
                      height: 120,
                      borderRadius: 28,
                    ),
                  );
                }
                if (loadingState == LoadingState.error) {
                  return AppErrorView(
                    message: 'Failed to load rewards',
                    onRetry: () => context.read<QuizRewardsPageBloc>().add(
                          const QuizRewardsPageLoadEvent(),
                        ),
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Gap(24),
                      FadeInDown(child: _HeaderProfileCard(t: t)),
                      const Gap(16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: _XpProgressSection(t: t),
                      ),
                      const Gap(16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: _StatsGrid(t: t),
                      ),
                      const Gap(16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: _DailyStreakSection(t: t),
                      ),
                      const Gap(16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _BadgesSection(t: t),
                      ),
                      const Gap(16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Builder(
                          builder: (context) {
                            final leaderboardEntries = context.select(
                              (QuizRewardsPageBloc bloc) =>
                                  bloc.state.leaderboardEntries,
                            );
                            return _LeaderboardSection(
                              t: t,
                              entries: leaderboardEntries,
                            );
                          },
                        ),
                      ),
                      const Gap(40),
                    ],
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
                    icon: Icons.arrow_back_ios_new_rounded,
                    variant: MentorXIconButtonVariant.outline,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Spacer(),
                  Text(
                    t.quizzes.rewards.title,
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

final class _HeaderProfileCard extends StatelessWidget {
  const _HeaderProfileCard({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(28),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(
              Icons.person_rounded,
              color: context.brandPrimaryColor,
              size: 30,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Mohamed',
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(4),
                Text(
                  'Grade 12 - Physics',
                  style: context.bodySecondaryStyle.copyWith(
                    color: context.textTertiaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.brandSecondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.brandSecondaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.workspace_premium_rounded,
                  color: context.brandSecondaryColor,
                  size: 16,
                ),
                const Gap(4),
                Text(
                  t.quizzes.rewards.goldLevel,
                  style: context.bodySecondaryStyle.copyWith(
                    color: context.brandSecondaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 1,
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

final class _XpProgressSection extends StatelessWidget {
  const _XpProgressSection({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    const currentXp = 2450;
    const targetXp = 3400;
    const progress = currentXp / targetXp;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: context.brandSecondaryColor,
                    size: 22,
                  ),
                  const Gap(6),
                  Text(
                    '${_formatNumber(currentXp)} XP',
                    style: context.bodyPrimaryStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Text(
                '${_formatNumber(targetXp)} XP ${t.quizzes.rewards.toNextLevel}',
                style: context.bodySecondaryStyle.copyWith(
                  fontSize: 12,
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Gap(16),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: context.brandSecondaryColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: context.brandSecondaryColor.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          value: _formatNumber(2450),
          label: t.quizzes.rewards.xpPoints,
          icon: Icons.bolt_rounded,
          color: context.brandSecondaryColor,
        ),
        const Gap(12),
        _StatItem(
          value: '18',
          label: t.quizzes.rewards.quizCompleted,
          icon: Icons.assignment_turned_in_rounded,
          color: context.statusSuccessColor,
        ),
        const Gap(12),
        _StatItem(
          value: '4',
          label: t.quizzes.rewards.badge,
          icon: Icons.military_tech_rounded,
          color: Colors.purpleAccent,
        ),
      ],
    );
  }
}

final class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MentorXGlassCard(
        style: Style(
          $box.padding.all(16),
          $box.borderRadius(24),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const Gap(12),
            Text(
              value,
              style: context.bodyPrimaryStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(4),
            Text(
              label,
              style: context.bodySecondaryStyle.copyWith(
                fontSize: 10,
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

final class _DailyStreakSection extends StatelessWidget {
  const _DailyStreakSection({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final dayKeys = ['sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri'];
    const checkedDays = {0, 1, 2, 3, 4};
    const todayIndex = 4;

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                color: context.brandSecondaryColor,
                size: 22,
              ),
              const Gap(10),
              Text(
                t.quizzes.rewards.dailyStreak,
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
                t.quizzes.rewards.streakDaysMsg(days: '5'),
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 13,
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final isChecked = checkedDays.contains(i);
              final isToday = i == todayIndex;

              return Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isChecked
                          ? context.statusSuccessColor
                          : context.backgroundPrimaryColor.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isToday
                            ? context.brandSecondaryColor
                            : (isChecked
                                  ? context.statusSuccessColor
                                  : context.borderPrimaryColor.withValues(
                                      alpha: 0.1,
                                    )),
                        width: 2,
                      ),
                    ),
                    child: isChecked
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                  const Gap(8),
                  Text(
                    _getDayName(t, dayKeys[i]),
                    style: context.bodySecondaryStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: isChecked
                          ? context.statusSuccessColor
                          : context.textTertiaryColor,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

final class _BadgesSection extends StatelessWidget {
  const _BadgesSection({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final badges = [
      _BadgeData(
        nameKey: 'lightningSpeed',
        icon: Icons.flash_on_rounded,
        isEarned: true,
      ),
      _BadgeData(
        nameKey: 'perfectScore',
        icon: Icons.stars_rounded,
        isEarned: true,
      ),
      _BadgeData(
        nameKey: 'fiveDayStreak',
        icon: Icons.local_fire_department_rounded,
        isEarned: true,
      ),
      _BadgeData(
        nameKey: 'tenQuizzes',
        icon: Icons.menu_book_rounded,
        isEarned: true,
      ),
      _BadgeData(
        nameKey: 'physicsLion',
        icon: Icons.pets_rounded,
        isEarned: false,
      ),
    ];

    return MentorXGlassCard(
      style: Style(
        $box.padding.all(20),
        $box.borderRadius(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.military_tech_rounded,
                color: context.brandSecondaryColor,
                size: 24,
              ),
              const Gap(10),
              Text(
                t.quizzes.rewards.earnedBadges,
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const Gap(24),
          Wrap(
            spacing: 16,
            runSpacing: 20,
            children: badges.map((b) => _BadgeCard(badge: b, t: t)).toList(),
          ),
        ],
      ),
    );
  }
}

final class _BadgeData {
  const _BadgeData({
    required this.nameKey,
    required this.icon,
    required this.isEarned,
  });
  final String nameKey;
  final IconData icon;
  final bool isEarned;
}

final class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge, required this.t});
  final _BadgeData badge;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final earned = badge.isEarned;
    final color = earned
        ? context.brandSecondaryColor
        : context.textTertiaryColor.withValues(alpha: 0.3);

    return SizedBox(
      width: 95,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: earned
                      ? color.withValues(alpha: 0.1)
                      : context.backgroundPrimaryColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    badge.icon,
                    color: color,
                    size: 30,
                  ),
                ),
              ),
              if (earned)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.statusSuccessColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.backgroundSecondaryColor,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                )
              else
                Icon(
                  Icons.lock_rounded,
                  color: context.textTertiaryColor.withValues(alpha: 0.5),
                  size: 20,
                ),
            ],
          ),
          const Gap(12),
          Text(
            _getBadgeName(t, badge.nameKey),
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: earned ? context.textPrimaryColor : context.textTertiaryColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

final class _LeaderboardSection extends StatelessWidget {
  const _LeaderboardSection({
    required this.t,
    required this.entries,
  });

  final dynamic t;
  final List<LeaderboardEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Icons.emoji_events_rounded,
                color: context.brandPrimaryColor,
                size: 20,
              ),
            ),
            const Gap(12),
            Text(
              t.quizzes.rewards.leaderboard,
              style: context.bodyPrimaryStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
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
            children: entries.map((entry) => _LeaderboardTile(entry: entry)).toList(),
          ),
        ),
      ],
    );
  }
}

final class _LeaderboardTile extends StatelessWidget {
  const _LeaderboardTile({required this.entry});
  final LeaderboardEntryEntity entry;

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
                fontWeight: FontWeight.w800,
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

String _formatNumber(int number) {
  return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
}

String _getDayName(dynamic t, String key) {
  return switch (key) {
    'sat' => t.quizzes.rewards.days.sat,
    'sun' => t.quizzes.rewards.days.sun,
    'mon' => t.quizzes.rewards.days.mon,
    'tue' => t.quizzes.rewards.days.tue,
    'wed' => t.quizzes.rewards.days.wed,
    'thu' => t.quizzes.rewards.days.thu,
    'fri' => t.quizzes.rewards.days.fri,
    _ => key.toUpperCase(),
  };
}

String _getBadgeName(dynamic t, String key) {
  return switch (key) {
    'lightningSpeed' => t.quizzes.rewards.badges.lightningSpeed,
    'perfectScore' => t.quizzes.rewards.badges.perfectScore,
    'fiveDayStreak' => t.quizzes.rewards.badges.fiveDayStreak,
    'tenQuizzes' => t.quizzes.rewards.badges.tenQuizzes,
    'physicsLion' => t.quizzes.rewards.badges.physicsLion,
    _ => key,
  };
}
