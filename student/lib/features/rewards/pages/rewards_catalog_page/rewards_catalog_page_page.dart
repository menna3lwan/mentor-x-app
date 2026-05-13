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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              t['rewardsTitle'] ?? 'Rewards Catalog',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            actions: [
              MentorXIconButton(
                icon: Icons.history_rounded,
                onPressed: () => const RewardsHistoryPageRoute().push(context),
                color: context.textPrimaryColor,
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
      body: Builder(
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
                          childAspectRatio: 0.72,
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
                const SliverToBoxAdapter(child: Gap(40)),
              ],
            ),
          );
        },
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
            color: context.brandPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -30,
            child: Icon(
              Icons.stars_rounded,
              size: 160,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (t['pointsBalance'] ?? 'POINTS BALANCE').toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                ),
              ),
              const Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$points',
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    t['points'] ?? 'Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text(
                t['redeemPointsDesc'] ??
                    'Redeem your points for exclusive rewards.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w700,
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
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
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
                    child: AppDynamicImage(
                      item.imageUrl ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  child: MentorXButton(
                    onPressed: onRedeem,
                    label: t['redeem'] ?? 'Redeem',
                    size: MentorXButtonSize.small,
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

