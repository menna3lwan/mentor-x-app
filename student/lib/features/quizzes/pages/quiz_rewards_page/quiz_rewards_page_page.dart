import 'package:flutter/material.dart';

import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/quiz_rewards_page_bloc.dart';
import '../../widgets/quiz_ui.dart';

class QuizRewardsPage extends StatelessWidget {
  const QuizRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: BlocBuilder<QuizRewardsPageBloc, QuizRewardsPageState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.loadingState == LoadingState.error) {
            return const Center(child: Text('Failed to load rewards'));
          }

          return Column(
            children: [
              QuizHeader(
                title: t['gamificationTitle']!,
                showBack: true,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _HeaderProfileCard(t: t),
                      const SizedBox(height: 16),
                      _XpProgressSection(t: t),
                      const SizedBox(height: 16),
                      _StatsGrid(t: t),
                      const SizedBox(height: 16),
                      _DailyStreakSection(t: t),
                      const SizedBox(height: 16),
                      _BadgesSection(t: t),
                      const SizedBox(height: 16),
                      _LeaderboardSection(
                        t: t,
                        entries: state.leaderboardEntries,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Header Profile Card
// ---------------------------------------------------------------------------
class _HeaderProfileCard extends StatelessWidget {
  const _HeaderProfileCard({required this.t});
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
        boxShadow: QuizUi.shadowMd,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '\u0623\u062D\u0645\u062F \u0645\u062D\u0645\u062F',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\u0627\u0644\u0635\u0641 \u0627\u0644\u062B\u0627\u0644\u062B \u0627\u0644\u062B\u0627\u0646\u0648\u064A - \u0627\u0644\u0641\u064A\u0632\u064A\u0627\u0621',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(QuizUi.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  t['goldLevel']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
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

// ---------------------------------------------------------------------------
// 2. XP Progress Section
// ---------------------------------------------------------------------------
class _XpProgressSection extends StatelessWidget {
  const _XpProgressSection({required this.t});
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    const currentXp = 2450;
    const targetXp = 3400;
    const progress = currentXp / targetXp;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
        boxShadow: QuizUi.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.accent,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${_formatNumber(currentXp)} XP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Text(
                '${_formatNumber(targetXp)} XP ${t['toNextLevel']!}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.greyDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.greyLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Stats Grid (3 columns)
// ---------------------------------------------------------------------------
class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.t});
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          value: _formatNumber(2450),
          label: t['xpPoints']!,
          icon: Icons.bolt_rounded,
          color: AppColors.accent,
        ),
        const SizedBox(width: 12),
        _StatItem(
          value: '18',
          label: t['quizCompleted']!,
          icon: Icons.assignment_turned_in_rounded,
          color: AppColors.teal,
        ),
        const SizedBox(width: 12),
        _StatItem(
          value: '4',
          label: t['badge']!,
          icon: Icons.military_tech_rounded,
          color: AppColors.purple,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(QuizUi.radiusMd),
          boxShadow: QuizUi.shadowSm,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.greyDark,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Daily Streak Section
// ---------------------------------------------------------------------------
class _DailyStreakSection extends StatelessWidget {
  const _DailyStreakSection({required this.t});
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    // Days: Sat=0..Fri=6; checked = 0,1,2,3,4 (Sat-Wed); today = 4 (Wed)
    final dayKeys = [
      'sat',
      'sun',
      'mon',
      'tue',
      'wed',
      'thu',
      'fri',
    ];
    const checkedDays = {0, 1, 2, 3, 4};
    const todayIndex = 4;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
        boxShadow: QuizUi.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.accent,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                t['dailyStreak']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            t['streakDaysMsg']!.replaceAll('%s', '5'),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.greyDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final isChecked = checkedDays.contains(i);
              final isToday = i == todayIndex;
              final isFuture = i > todayIndex;

              Color bgColor;
              Color borderColor;
              Widget? child;

              if (isChecked) {
                bgColor = AppColors.green;
                borderColor = AppColors.green;
                child = const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 18,
                );
              } else if (isToday) {
                bgColor = Colors.transparent;
                borderColor = AppColors.accent;
                child = null;
              } else if (isFuture) {
                bgColor = Colors.transparent;
                borderColor = AppColors.greyLight;
                child = null;
              } else {
                bgColor = Colors.transparent;
                borderColor = AppColors.greyLight;
                child = null;
              }

              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 2),
                    ),
                    child: child != null ? Center(child: child) : null,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t[dayKeys[i]]!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isChecked ? AppColors.green : AppColors.greyDark,
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

// ---------------------------------------------------------------------------
// 5. Badges Section
// ---------------------------------------------------------------------------
class _BadgesSection extends StatelessWidget {
  const _BadgesSection({required this.t});
  final Map<String, String> t;

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
        boxShadow: QuizUi.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.military_tech_rounded,
                color: AppColors.accent,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                t['earnedBadges']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: badges.map((b) => _BadgeCard(badge: b, t: t)).toList(),
          ),
        ],
      ),
    );
  }
}

class _BadgeData {
  const _BadgeData({
    required this.nameKey,
    required this.icon,
    required this.isEarned,
  });
  final String nameKey;
  final IconData icon;
  final bool isEarned;
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge, required this.t});
  final _BadgeData badge;
  final Map<String, String> t;

  @override
  Widget build(BuildContext context) {
    final earned = badge.isEarned;
    final iconColor = earned ? AppColors.accent : AppColors.grey;
    final bgColor = earned
        ? AppColors.accent.withValues(alpha: 0.10)
        : AppColors.greyLight;

    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(badge.icon, color: iconColor, size: 28),
              ),
              if (earned)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              if (!earned)
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: AppColors.grey,
                    size: 22,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            t[badge.nameKey]!,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: earned ? AppColors.primary : AppColors.grey,
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

// ---------------------------------------------------------------------------
// 6. Leaderboard Section
// ---------------------------------------------------------------------------
class _LeaderboardSection extends StatelessWidget {
  const _LeaderboardSection({required this.t, required this.entries});
  final Map<String, String> t;
  final List<LeaderboardEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
        boxShadow: QuizUi.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.leaderboard_rounded,
                color: AppColors.accent,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                t['leaderboard']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (entries.isEmpty)
            const Center(child: Text('No entries found'))
          else
            ...entries.map((e) => _LeaderboardRow(entry: e, t: t)),
        ],
      ),
    );
  }
}


class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.entry, required this.t});
  final LeaderboardEntryEntity entry;
  final Map<String, String> t;

  Color _medalColor() {
    switch (entry.rank) {
      case 1:
        return AppColors.accent;
      case 2:
        return AppColors.grey;
      case 3:
        return AppColors.accentDark;
      default:
        return AppColors.greyDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? AppColors.accent.withValues(alpha: 0.10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(QuizUi.radiusSm),
        border: entry.isCurrentUser
            ? Border.all(color: AppColors.accent.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 28,
            child: isTop3
                ? Icon(
                    Icons.emoji_events_rounded,
                    color: _medalColor(),
                    size: 22,
                  )
                : Text(
                    '${entry.rank}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.greyDark,
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          // Avatar placeholder
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: entry.isCurrentUser
                  ? AppColors.accent.withValues(alpha: 0.2)
                  : AppColors.greyLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_rounded,
              size: 20,
              color: entry.isCurrentUser ? AppColors.accent : AppColors.grey,
            ),
          ),
          const SizedBox(width: 10),
          // Name & stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.studentName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: entry.isCurrentUser
                        ? FontWeight.w700
                        : FontWeight.w600,
                    color: entry.isCurrentUser
                        ? AppColors.accent
                        : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${entry.quizCount ?? 0} ${t['quiz']!} . ${entry.score.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.greyDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Points
          Text(
            _formatNumber(entry.points),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: entry.isCurrentUser ? AppColors.accent : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
String _formatNumber(int n) {
  if (n >= 1000) {
    final whole = n ~/ 1000;
    final remainder = (n % 1000) ~/ 100;
    if (remainder == 0) return '$whole,000';
    return '$whole,${(n % 1000).toString().padLeft(3, '0')}';
  }
  return '$n';
}
