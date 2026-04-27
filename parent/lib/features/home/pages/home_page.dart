import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import '../bloc/home_bloc.dart';
import '../widgets/child_switcher.dart';
import '../widgets/parent_hero_card.dart';
import '../widgets/parent_activity_feed.dart';
import '../widgets/parent_quick_actions_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return Scaffold(
            backgroundColor: palette.backgroundPrimary,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
              ),
            ),
          );
        }

        if (state.status == HomeStatus.failure) {
          return Scaffold(
            backgroundColor: palette.backgroundPrimary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomIn(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: palette.statusDanger.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.error_outline_rounded, size: 48, color: palette.statusDanger),
                      ),
                    ),
                    const Gap(24),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: palette.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      state.errorMessage ?? t.unableToLoad,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: palette.textSecondary, fontSize: 14, height: 1.5),
                    ),
                    const Gap(32),
                    MentorXButton(
                      onPressed: () => context.read<HomeBloc>().add(HomeStarted()),
                      label: t.retry,
                      size: MentorXButtonSize.medium,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: palette.backgroundPrimary,
          body: RefreshIndicator(
            color: palette.brandPrimary,
            backgroundColor: Colors.white,
            displacement: 100,
            onRefresh: () async {
              context.read<HomeBloc>().add(HomeChildSwitched(state.selectedChild!));
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Premium Header
                SliverToBoxAdapter(
                  child: _BuildPremiumHeader(palette: palette, state: state),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: palette.backgroundSecondary.withValues(alpha: 0.4),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(12),
                        // Child Switcher
                        const ChildSwitcher(),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(8),
                              if (state.summary != null && state.selectedChild != null) ...[
                                ParentHeroCard(
                                  summary: state.summary!,
                                  selectedChildId: state.selectedChild!.id,
                                ),
                                const Gap(32),
                              ],

                              // Quick Actions
                              FadeInLeft(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  t.services,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: palette.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              const ParentQuickActionsGrid(),
                              
                              const Gap(40),

                              // Recent Activity
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FadeInLeft(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      t.recentActivity,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: palette.textPrimary,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                  FadeInRight(
                                    duration: const Duration(milliseconds: 500),
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        t.viewAll,
                                        style: TextStyle(
                                          color: palette.brandPrimary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(12),
                              ParentActivityFeed(activities: state.recentActivity),

                              const Gap(120), // Bottom padding for FAB or Nav
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildPremiumHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final HomeState state;

  const _BuildPremiumHeader({required this.palette, required this.state});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 32,
        left: 24,
        right: 24,
      ),
      color: palette.backgroundPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  t.welcomeBack,
                  style: TextStyle(
                    color: palette.textTertiary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(4),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Parent Account', // Placeholder for user name
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
            ],
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none_rounded, color: palette.textPrimary, size: 26),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: palette.statusDanger,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
