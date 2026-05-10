import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/quiz_rewards_page_bloc.dart';

final class QuizRewardsPage extends StatelessWidget {
  const QuizRewardsPage({super.key});

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
                child: BlocBuilder<QuizRewardsPageBloc, QuizRewardsPageState>(
                  builder: (context, state) {
                    if (state.loadingState == LoadingState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.loadingState == LoadingState.error) {
                      return Center(
                        child: Text(
                          'Failed to load rewards',
                          style: TextStyle(
                            color: context.textSecondaryColor,
                            fontWeight: FontWeight.w800,
                          ),
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
                            child: _LeaderboardSection(
                              t: t,
                              entries: state.leaderboardEntries,
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
              t['gamificationTitle']!,
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

final class _HeaderProfileCard extends StatelessWidget {
  const _HeaderProfileCard({required this.t});
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Grade 12 - Physics',
                      style: TextStyle(
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
                      t['goldLevel'] ?? 'GOLD',
                      style: TextStyle(
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
        ),
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${_formatNumber(targetXp)} XP ${t['toNextLevel'] ?? 'to next level'}',
                    style: TextStyle(
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
        ),
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
          label: t['xpPoints'] ?? 'XP Points',
          icon: Icons.bolt_rounded,
          color: context.brandSecondaryColor,
        ),
        const Gap(12),
        _StatItem(
          value: '18',
          label: t['quizCompleted'] ?? 'Quizzes',
          icon: Icons.assignment_turned_in_rounded,
          color: context.statusSuccessColor,
        ),
        const Gap(12),
        _StatItem(
          value: '4',
          label: t['badge'] ?? 'Badges',
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
      child: Container(
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.2),
                          color.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const Gap(12),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: color,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    label,
                    style: TextStyle(
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
          ),
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                    t['dailyStreak'] ?? 'Daily Streak',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Text(
                t['streakDaysMsg']?.replaceAll('%s', '5') ??
                    'You have a 5-day streak!',
                style: TextStyle(
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
                        t[dayKeys[i]] ?? dayKeys[i].toUpperCase(),
                        style: TextStyle(
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
        ),
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                    t['earnedBadges'] ?? 'Badges',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
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
        ),
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
                  gradient: earned
                      ? LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.2),
                            color.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: earned
                      ? null
                      : context.backgroundPrimaryColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  boxShadow: earned
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
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
                        gradient: LinearGradient(
                          colors: [
                            context.statusSuccessColor,
                            context.statusSuccessColor.withValues(alpha: 0.8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.backgroundSecondaryColor,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.statusSuccessColor.withValues(alpha: 0.3),
                            blurRadius: 10,
                          ),
                        ],
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
            t[badge.nameKey] ?? badge.nameKey,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: earned
                  ? context.textPrimaryColor
                  : context.textTertiaryColor,
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

final class _LeaderboardSection extends StatelessWidget {
  const _LeaderboardSection({required this.t, required this.entries});
  final dynamic t;
  final List<LeaderboardEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.leaderboard_rounded,
                    color: context.brandSecondaryColor,
                    size: 22,
                  ),
                  const Gap(10),
                  Text(
                    t['leaderboard'] ?? 'Leaderboard',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const Gap(24),
              if (entries.isEmpty)
                Center(
                  child: Text(
                    'No entries found',
                    style: TextStyle(
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              else
                ...entries.take(5).map((e) => _LeaderboardRow(entry: e, t: t)),
            ],
          ),
        ),
      ),
    );
  }
}

final class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.entry, required this.t});
  final LeaderboardEntryEntity entry;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;
    final rankColor = entry.rank == 1
        ? const Color(0xFFFFD700)
        : (entry.rank == 2
              ? const Color(0xFFC0C0C0)
              : (entry.rank == 3
                    ? const Color(0xFFCD7F32)
                    : context.textTertiaryColor));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? context.brandPrimaryColor.withValues(alpha: 0.1)
            : context.backgroundPrimaryColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: entry.isCurrentUser
              ? context.brandPrimaryColor.withValues(alpha: 0.2)
              : context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: isTop3
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: rankColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.emoji_events_rounded, color: rankColor, size: 20),
                        )
                      : Text(
                          '${entry.rank}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: context.textTertiaryColor,
                          ),
                        ),
                ),
                const Gap(12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.backgroundSecondaryColor,
                        context.backgroundSecondaryColor.withValues(alpha: 0.5),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.borderPrimaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 22,
                    color: context.textTertiaryColor.withValues(alpha: 0.8),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.studentName,
                        style: TextStyle(
                          color: context.textPrimaryColor,
                          fontWeight:
                              entry.isCurrentUser ? FontWeight.w900 : FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        '${_formatNumber(entry.score)} XP',
                        style: TextStyle(
                          color: context.textTertiaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (entry.rank == 1)
                  FadeInRight(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: rankColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '👑 TOP 1',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: rankColor,
                          letterSpacing: 1,
                        ),
                      ),
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

String _formatNumber(num number) {
  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}k';
  }
  return number.toInt().toString();
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
