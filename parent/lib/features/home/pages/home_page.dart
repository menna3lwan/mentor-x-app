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
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppDashboardScaffold(
          title: t.welcomeBack,
          onRefresh: () async {
            if (state.selectedChild != null) {
              context.read<HomeBloc>().add(HomeRefreshRequested());
            }
          },
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            const Gap(8),
          ],
          body: state.status == HomeStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : state.status == HomeStatus.failure
                  ? AppErrorView(
                      message: state.errorMessage ?? t.unableToLoad,
                      onRetry: () => context.read<HomeBloc>().add(HomeStarted()),
                    )
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInDown(
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    'Parent Account',
                                    style: TextStyle(
                                      color: context.textPrimaryColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1.0,
                                    ),
                                  ),
                                ),
                                const Gap(24),
                                const ChildSwitcher(),
                                const Gap(24),
                                if (state.summary != null &&
                                    state.selectedChild != null) ...[
                                  ParentHeroCard(
                                    summary: state.summary!,
                                    selectedChildId: state.selectedChild!.id,
                                  ),
                                  const Gap(32),
                                ],
                                AppSectionHeader(
                                  title: t.services,
                                ),
                                const Gap(16),
                                const ParentQuickActionsGrid(),
                                const Gap(32),
                                AppSectionHeader(
                                  title: t.recentActivity,
                                ),
                                const Gap(12),
                                ParentActivityFeed(
                                  activities: state.recentActivity,
                                ),
                                const Gap(100),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}

