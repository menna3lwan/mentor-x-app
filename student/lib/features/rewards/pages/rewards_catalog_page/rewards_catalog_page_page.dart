import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_page_bloc.dart';
import '../../../../core/routing/app_routes.dart';

class RewardsCatalogPage extends StatelessWidget {
  const RewardsCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocBuilder<RewardsPageBloc, RewardsPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: palette.brandPrimary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4)),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['rewardsTitle'] ?? 'Rewards Catalog',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.history_rounded),
                    onPressed: () => const RewardsHistoryPageRoute().push(context),
                  ),
                  const Gap(8),
                ],
              ),
            ),
          ),
          body: _buildBody(context, state, palette, t),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    RewardsPageState state,
    MentorXThemeColorPalette palette,
    dynamic t,
  ) {
    if (state.isFirstLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final items = state.itemsSection.data ?? [];

    return RefreshIndicator(
      color: palette.brandPrimary,
      onRefresh: () async {
        context.read<RewardsPageBloc>().add(RewardsPageStartedEvent());
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _PointsHeader(
                points: state.pointsSection.data ?? 0,
                palette: palette,
                t: t,
              ),
            ),
          ),
          if (items.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: FadeInUp(child: _EmptyRewards(palette: palette, t: t)),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        palette: palette,
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
            ),
          const SliverToBoxAdapter(child: Gap(40)),
        ],
      ),
    );
  }
}

class _PointsHeader extends StatelessWidget {
  final int points;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _PointsHeader({required this.points, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.stars_rounded,
              size: 140,
              color: Colors.white.withValues(alpha: 0.1),
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
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 1.2,
                ),
              ),
              const Gap(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$points',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    t['points'] ?? 'Points',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Text(
                t['redeemPointsDesc'] ?? 'Redeem your points for exclusive rewards.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardItemCard extends StatelessWidget {
  final dynamic item;
  final MentorXThemeColorPalette palette;
  final VoidCallback onRedeem;

  const _RewardItemCard({
    required this.item,
    required this.palette,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network(
                      item.imageUrl ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: palette.brandPrimary.withValues(alpha: 0.05),
                        child: Icon(Icons.card_giftcard_rounded, color: palette.brandPrimary.withValues(alpha: 0.2), size: 40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.stars_rounded, color: Colors.amber, size: 12),
                        const Gap(6),
                        Text(
                          '${item.requiredPoints}',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: palette.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const Gap(12),
                SizedBox(
                  width: double.infinity,
                  child: SizedBox(
                    height: 40,
                    child: MentorXButton(
                      onPressed: onRedeem,
                      label: t['redeem'] ?? 'Redeem',
                      size: MentorXButtonSize.small,
                    ),
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

class _EmptyRewards extends StatelessWidget {
  const _EmptyRewards({required this.palette, required this.t});
  final MentorXThemeColorPalette palette;
  final dynamic t;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20),
              ],
            ),
            child: Icon(
              Icons.card_giftcard_rounded,
              size: 80,
              color: palette.textTertiary.withValues(alpha: 0.2),
            ),
          ),
          const Gap(32),
          Text(
            t['noRewards'] ?? 'No rewards available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
            ),
          ),
          const Gap(10),
          Text(
            t['noRewardsDesc'] ?? 'Check back later for new items.',
            style: TextStyle(
              fontSize: 15,
              color: palette.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
