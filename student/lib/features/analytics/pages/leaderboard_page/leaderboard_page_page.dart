import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
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
    final t = context.t.student['analytics'] as dynamic;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              Gap(MediaQuery.paddingOf(context).top),
              _buildAppBar(context, t),
              _CourseFilter(
                selectedId: state.selectedCourseId,
                courses: state.courses,
                onChanged: onCourseChanged,
                t: t,
              ),
              Expanded(
                child: state.loadingState == LoadingState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () async => onRefresh(),
                        color: context.brandPrimaryColor,
                        child: _buildContent(context, t),
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: state.myRank != null
          ? _MyRankBar(
              entry: state.myRank!,
            )
          : null,
    );
  }

  Widget _buildAppBar(BuildContext context, dynamic t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              t.gradeVsPeers,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
          ),
          IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh_rounded, color: context.textPrimaryColor),
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
      return Center(
        child: Text(
          'No rankings available.',
          style: TextStyle(color: context.textSecondaryColor),
        ),
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
  final List<CourseSummaryEntity> courses;
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
                label: c.title,
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
              : context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? context.brandPrimaryColor
                : context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : context.textSecondaryColor,
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
              width: isWinner ? 80 : 64,
              height: isWinner ? 80 : 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
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
                top: -25,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 1200),
                  delay: const Duration(milliseconds: 800),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFFFFD700),
                    size: 32,
                  ),
                ),
              ),
            Positioned(
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
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
                    fontSize: 10,
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
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w900,
            fontSize: isWinner ? 14 : 12,
            letterSpacing: -0.2,
          ),
        ),
        const Gap(4),
        Text(
          '${entry.score}%',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: isWinner ? 16 : 14,
          ),
        ),
        const Gap(12),
        Container(
          width: isWinner ? 100 : 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withValues(alpha: 0.4),
                color.withValues(alpha: 0.1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$rank',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.5),
                fontSize: isWinner ? 40 : 32,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: context.backgroundSecondaryColor.withValues(alpha: 0.8),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.backgroundTertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '#${entry.rank}',
                      style: TextStyle(
                        color: context.textPrimaryColor,
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
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                Text(
                  '${entry.score}%',
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: -0.5,
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

final class _MyRankBar extends StatelessWidget {
  final LeaderboardEntryEntity entry;

  const _MyRankBar({required this.entry});

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
        color: context.backgroundSecondaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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
                  color: context.brandPrimaryColor.withValues(alpha: 0.3),
                  blurRadius: 8,
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
                  'Your Standing',
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
                Text(
                  'You',
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${entry.score}%',
            style: TextStyle(
              color: context.brandPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 22,
              letterSpacing: -1,
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
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.15),
            size: 300,
          ),
        ),
        Positioned(
          top: 200,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            size: 250,
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
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
