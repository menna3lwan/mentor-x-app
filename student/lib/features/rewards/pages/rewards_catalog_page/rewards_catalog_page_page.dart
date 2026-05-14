import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_page_bloc.dart';
import '../../../../core/routing/app_routes.dart';

final class RewardsCatalogPage extends StatelessWidget {
  const RewardsCatalogPage({super.key});

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
                child: Builder(
                  builder: (context) {
                    final isFirstLoading = context.select(
                      (RewardsPageBloc bloc) => bloc.state.isFirstLoading,
                    );

                    if (isFirstLoading) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: MentorXSkeleton(height: 180, borderRadius: 32),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.72,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                              itemCount: 6,
                              itemBuilder: (_, _) => const MentorXSkeleton(
                                height: 200,
                                borderRadius: 28,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return RefreshIndicator(
                      color: context.brandPrimaryColor,
                      onRefresh: () async {
                        context.read<RewardsPageBloc>().add(RewardsPageStartedEvent());
                      },
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: FadeInDown(
                              duration: const Duration(milliseconds: 600),
                              child: Builder(
                                builder: (context) {
                                  final points = context.select(
                                    (RewardsPageBloc bloc) =>
                                        bloc.state.pointsSection.data ?? 0,
                                  );
                                  return _PointsHeader(points: points, t: t);
                                },
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final items = context.select(
                                (RewardsPageBloc bloc) =>
                                    bloc.state.itemsSection.data ?? [],
                              );

                              if (items.isEmpty) {
                                return SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: AppEmptyView(
                                    title: t['noRewards'] ?? 'No rewards available',
                                    message: t['noRewardsDesc'] ?? 'Check back later for new items.',
                                    icon: Icons.card_giftcard_rounded,
                                  ),
                                );
                              }
                              return SliverPadding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                                sliver: SliverGrid(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.68,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final item = items[index];
                                      return FadeInUp(
                                        duration: const Duration(milliseconds: 500),
                                        delay: Duration(milliseconds: 100 * index),
                                        child: _RewardItemCard(
                                          item: item,
                                          t: t,
                                          onRedeem: () {
                                            context.read<RewardsPageBloc>().add(
                                              RewardsPageClaimRequestedEvent(item.id),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    childCount: items.length,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SliverToBoxAdapter(child: Gap(100)),
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
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
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
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: MentorXIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: MentorXIconButtonSize.small,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOYALTY',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t['rewardsTitle'] ?? 'Rewards Catalog',
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              MentorXIconButton(
                icon: Icons.history_rounded,
                onPressed: () => const RewardsHistoryPageRoute().push(context),
                color: context.textPrimaryColor,
                size: MentorXIconButtonSize.small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _PointsHeader extends StatelessWidget {
  final int points;
  final dynamic t;

  const _PointsHeader({
    required this.points,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.brandPrimaryColor,
            context.brandSecondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 140,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (t['pointsBalance'] ?? 'POINTS BALANCE').toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.8),
                  letterSpacing: 2.0,
                ),
              ),
              const Gap(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$points',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -2,
                      height: 1.0,
                    ),
                  ),
                    const SizedBox(width: 10),
                  Text(
                    t['points'] ?? 'Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        t['redeemPointsDesc'] ??
                            'Redeem your points for exclusive rewards.',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _RewardItemCard extends StatelessWidget {
  final dynamic item;
  final dynamic t;
  final VoidCallback onRedeem;

  const _RewardItemCard({
    required this.item,
    required this.t,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    child: Hero(
                      tag: 'reward_image_${item.id}',
                      child: AppDynamicImage(
                        item.imageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const Gap(6),
                        Text(
                          '${item.requiredPoints}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
                ),
                const Gap(14),
                SizedBox(
                  width: double.infinity,
                  child:                 MentorXButton(
                    onPressed: onRedeem,
                    label: t['redeem'] ?? 'Redeem',
                    size: MentorXButtonSize.small,
                    color: context.brandPrimaryColor,
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
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
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
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
      ),
    );
  }
}

