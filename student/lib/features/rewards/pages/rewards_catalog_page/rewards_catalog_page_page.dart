import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/rewards_page_bloc.dart';
import '../../../../core/routing/app_routes.dart';

class RewardsCatalogPage extends StatelessWidget {
  const RewardsCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return BlocBuilder<RewardsPageBloc, RewardsPageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: _buildAppBar(context, state, palette),
          body: _buildBody(context, state, palette),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    RewardsPageState state,
    MentorXThemeColorPalette palette,
  ) {
    return AppBar(
      title: const Text(
        'Rewards Catalog',
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.history_rounded),
          onPressed: () => const RewardsHistoryPageRoute().push(context),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody(
    BuildContext context,
    RewardsPageState state,
    MentorXThemeColorPalette palette,
  ) {
    if (state.isFirstLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _PointsHeader(
            points: state.pointsSection.data ?? 0,
            palette: palette,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.itemsSection.data![index];
                return _RewardItemCard(
                  item: item,
                  onRedeem: () {
                    context.read<RewardsPageBloc>().add(
                      RewardsPageClaimRequestedEvent(item.id),
                    );
                  },
                );
              },
              childCount: state.itemsSection.data?.length ?? 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _PointsHeader extends StatelessWidget {
  final int points;
  final MentorXThemeColorPalette palette;

  const _PointsHeader({required this.points, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Balance',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$points Points',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
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
  final VoidCallback onRedeem;

  const _RewardItemCard({required this.item, required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Container(
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                item.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: palette.brandPrimary.withOpacity(0.1),
                  child: Icon(
                    Icons.card_giftcard_rounded,
                    color: palette.brandPrimary,
                  ),
                ),
              ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      size: 14,
                      color: palette.brandPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.requiredPoints} pts',
                      style: TextStyle(
                        color: palette.brandPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onRedeem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: palette.brandPrimary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Redeem',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
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
