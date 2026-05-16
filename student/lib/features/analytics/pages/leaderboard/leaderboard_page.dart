import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/leaderboard_page_bloc.dart';

final class LeaderboardPagePage extends StatelessWidget {
  final LeaderboardPageState state;
  final ValueChanged<String?> onCourseChanged;
  final VoidCallback onRefresh;

  const LeaderboardPagePage({
    super.key,
    required this.state,
    required this.onCourseChanged,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.analytics;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D19),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B0D19),
              Color(0xFF161A30),
              Color(0xFF0B0D19),
            ],
          ),
        ),
        child: Column(
          children: [
            Gap(MediaQuery.paddingOf(context).top + 12),
            _buildAppBar(context, t),
            _CourseFilter(
              selectedId: state.selectedCourseId,
              courses: state.courses,
              onChanged: onCourseChanged,
              t: t,
            ),
            Expanded(
              child: state.loadingState == LoadingState.loading
                  ? ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: 8,
                      itemBuilder: (_, _) => const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: MentorXSkeleton(height: 70, borderRadius: 24),
                      ),
                    )
                  : state.loadingState == LoadingState.error
                  ? AppErrorView(
                      title: t.leaderboardError,
                      message: state.errorMessage ?? t.title,
                      onRetry: onRefresh,
                    )
                  : RefreshIndicator(
                      onRefresh: () async => onRefresh(),
                      color: context.brandPrimaryColor,
                      child: _buildContent(context, t),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: state.myRank != null
          ? _MyRankBar(
              entry: state.myRank!,
              t: t,
            )
          : null,
    );
  }

  Widget _buildAppBar(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          MentorXIconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: Icons.arrow_back_ios_new_rounded,
            variant: MentorXIconButtonVariant.outline,
            size: MentorXIconButtonSize.small,
          ),
          Expanded(
            child: Text(
              t.gradeVsPeers,
              textAlign: TextAlign.center,
              style: context.titleH3Style.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                color: Colors.white,
              ),
            ),
          ),
          MentorXIconButton(
            onPressed: onRefresh,
            icon: Icons.refresh_rounded,
            variant: MentorXIconButtonVariant.outline,
            size: MentorXIconButtonSize.small,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    dynamic t,
  ) {
    if (state.leaderboard.isEmpty) {
      return AppEmptyView(
        title: t.noRankingsTitle,
        message: t.noRankingsDesc,
        icon: Icons.workspace_premium_rounded,
      );
    }

    final top3 = state.leaderboard.take(3).toList();
    final theRest = state.leaderboard.skip(3).toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: _Podium(
              topEntries: top3,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = theRest[index];
                return FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  delay: Duration(milliseconds: 50 * index),
                  child: _LeaderboardTile(
                    entry: entry,
                  ),
                );
              },
              childCount: theRest.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: Gap(100)), // Spacer for bottom bar
      ],
    );
  }
}

final class _CourseFilter extends StatelessWidget {
  final String? selectedId;
  final List<EnrollmentEntity> courses;
  final ValueChanged<String?> onChanged;
  final dynamic t;

  const _CourseFilter({
    required this.selectedId,
    required this.courses,
    required this.onChanged,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          _FilterChip(
            label: t.allCourses,
            isSelected: selectedId == null,
            onTap: () => onChanged(null),
          ),
          const Gap(8),
          ...courses.map(
            (c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FilterChip(
                label: c.courseTitle ?? '',
                isSelected: selectedId == c.id,
                onTap: () => onChanged(c.id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.brandPrimaryColor
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? context.brandPrimaryColor
                : Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

final class _Podium extends StatelessWidget {
  final List<LeaderboardEntryEntity> topEntries;

  const _Podium({required this.topEntries});

  @override
  Widget build(BuildContext context) {
    final first = topEntries.isNotEmpty ? topEntries[0] : null;
    final second = topEntries.length > 1 ? topEntries[1] : null;
    final third = topEntries.length > 2 ? topEntries[2] : null;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (second != null)
            Expanded(
              child: FadeInLeft(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: _PodiumSpot(
                  entry: second,
                  rank: 2,
                  height: 100,
                  color: const Color(0xFFC0C0C0),
                  glowColor: Colors.blueGrey,
                ),
              ),
            ),
          if (first != null)
            Expanded(
              child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _PodiumSpot(
                  entry: first,
                  rank: 1,
                  height: 140,
                  color: const Color(0xFFFFD700),
                  glowColor: Colors.amber,
                  isWinner: true,
                ),
              ),
            ),
          if (third != null)
            Expanded(
              child: FadeInRight(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: _PodiumSpot(
                  entry: third,
                  rank: 3,
                  height: 80,
                  color: const Color(0xFFCD7F32),
                  glowColor: Colors.deepOrangeAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final class _PodiumSpot extends StatelessWidget {
  final LeaderboardEntryEntity entry;
  final int rank;
  final double height;
  final Color color;
  final Color glowColor;
  final bool isWinner;

  const _PodiumSpot({
    required this.entry,
    required this.rank,
    required this.height,
    required this.color,
    required this.glowColor,
    this.isWinner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: isWinner ? 84 : 68,
              height: isWinner ? 84 : 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipOval(
                child: AppDynamicImage(
                  'https://ui-avatars.com/api/?name=${entry.studentName}&background=random&color=fff&size=128',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isWinner)
              Positioned(
                top: -30,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 1200),
                  delay: const Duration(milliseconds: 800),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFFFFD700),
                    size: 36,
                  ),
                ),
              ),
            Positioned(
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(24),
        Text(
          entry.studentName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: isWinner ? 14 : 12,
            letterSpacing: -0.2,
          ),
        ),
        const Gap(4),
        Text(
          '${entry.score.toStringAsFixed(1)}%',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: isWinner ? 18 : 16,
            shadows: [
              Shadow(
                color: glowColor.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const Gap(12),
        Container(
          width: isWinner ? 110 : 90,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.6),
                color.withValues(alpha: 0.2),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: color, width: 2),
              left: BorderSide(color: color.withValues(alpha: 0.2), width: 1),
              right: BorderSide(color: color.withValues(alpha: 0.2), width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$rank',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: isWinner ? 48 : 36,
                fontWeight: FontWeight.w900,
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

  const _LeaderboardTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isTop3 = entry.rank <= 3;
    final color = entry.rank == 1
        ? const Color(0xFFFFD700)
        : (entry.rank == 2
              ? const Color(0xFFC0C0C0)
              : (entry.rank == 3
                    ? const Color(0xFFCD7F32)
                    : context.brandSecondaryColor));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isTop3
              ? color.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.05),
          width: isTop3 ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isTop3
                ? color.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: ExcludeSemantics(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: Colors.white.withValues(alpha: 0.03),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isTop3
                          ? color.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isTop3
                            ? color.withValues(alpha: 0.3)
                            : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '#${entry.rank}',
                        style: TextStyle(
                          color: isTop3 ? color : Colors.white70,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: AppDynamicImage(
                      'https://ui-avatars.com/api/?name=${entry.studentName}&background=random&color=fff',
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      entry.studentName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  Text(
                    '${entry.score.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: isTop3 ? color : context.brandPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      shadows: isTop3
                          ? [
                              Shadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 5,
                              ),
                            ]
                          : [],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _MyRankBar extends StatelessWidget {
  final LeaderboardEntryEntity entry;
  final dynamic t;

  const _MyRankBar({
    required this.entry,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.paddingOf(context).bottom + 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0F111A),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(
            color: context.brandPrimaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.brandPrimaryColor,
                  context.brandSecondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: context.brandPrimaryColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '#${entry.rank}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.yourStanding,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
                Text(
                  t.you,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${entry.score.toStringAsFixed(1)}%',
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 22,
              letterSpacing: -1,
              shadows: [
                Shadow(
                  color: context.brandPrimaryColor.withValues(alpha: 0.5),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
