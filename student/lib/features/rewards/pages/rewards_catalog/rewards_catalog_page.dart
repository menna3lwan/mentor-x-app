import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class RewardsCatalogPage extends StatelessWidget {
  final bool isFirstLoading;
  final int points;
  final List<RewardItemEntity> items;
  final VoidCallback onRefresh;
  final Function(RewardItemEntity) onRedeem;

  const RewardsCatalogPage({
    super.key,
    required this.isFirstLoading,
    required this.points,
    required this.items,
    required this.onRefresh,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.rewards;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(t: t),
          Expanded(
            child: Builder(
              builder: (context) {
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                  onRefresh: () async => onRefresh(),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: _PointsHeader(points: points, t: t),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (items.isEmpty) {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: AppEmptyView(
                                title: t.noRewards,
                                message: t.noRewardsDesc,
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
                                      onRedeem: () => onRedeem(item),
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
              MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOYALTY',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.rewardsTitle,
                      style: context.titleH1Style.copyWith(
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
                onPressed: () => const RewardsHistoryRoute().push(context),
                variant: MentorXIconButtonVariant.ghost,
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
                t.pointsBalance.toUpperCase(),
                style: context.bodySecondaryStyle.copyWith(
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
                    style: context.titleH1Style.copyWith(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -2,
                      height: 1.0,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    t.points,
                    style: context.titleH2Style.copyWith(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
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
                        t.redeemPointsDesc,
                        style: context.bodySecondaryStyle.copyWith(
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
  final RewardItemEntity item;
  final dynamic t;
  final VoidCallback onRedeem;

  const _RewardItemCard({
    required this.item,
    required this.t,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.padding.all(0),
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
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: -0.2,
                    height: 1.2,
                  ),
                ),
                const Gap(14),
                SizedBox(
                  width: double.infinity,
                  child: MentorXButton(
                    onPressed: onRedeem,
                    label: t.redeem,
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
