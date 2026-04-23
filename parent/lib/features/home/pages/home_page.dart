import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../bloc/home_bloc.dart';
import '../widgets/child_switcher.dart';
import '../widgets/parent_hero_card.dart';
import '../widgets/parent_activity_feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const AppDashboardScaffold(
            title: 'Dashboard',
            body: Center(
              child: MentorXShimmer(
                child: MentorXSkeleton(height: 200, width: double.infinity),
              ),
            ),
          );
        }

        if (state.status == HomeStatus.failure) {
          return AppDashboardScaffold(
            title: 'Dashboard',
            body: AppErrorView(
              message: state.errorMessage ?? 'Please check your connection and try again.',
              onRetry: () => context.read<HomeBloc>().add(HomeStarted()),
            ),
          );
        }

        if (state.children.isEmpty) {
          return AppDashboardScaffold(
            title: 'Dashboard',
            body: AppEmptyView(
              icon: Icons.people_outline,
              title: 'No children linked',
              message: 'Link your child\'s account to start monitoring their progress.',
              actionLabel: 'Link a Child',
              onAction: () {
                // Navigate to add child
              },
            ),
          );
        }

        return AppDashboardScaffold(
          title: 'Dashboard',
          backgroundColor: context.backgroundPrimaryColor,
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeRefreshRequested());
          },
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none_rounded, color: context.brandPrimaryColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.refresh_rounded, color: context.brandPrimaryColor),
              onPressed: () {
                context.read<HomeBloc>().add(HomeRefreshRequested());
              },
            ),
          ],
          body: ListView(
            children: [
              const ChildSwitcher(),
              if (state.summary != null && state.selectedChild != null)
                ParentHeroCard(
                  summary: state.summary!,
                  selectedChildId: state.selectedChild!.id,
                ),
              
              const AppSectionHeader(title: 'Recent Activity'),
              ParentActivityFeed(activities: state.recentActivity),
              
              if (state.announcements.isNotEmpty) ...[
                const AppSectionHeader(title: 'Announcements'),
                ...state.announcements.map(
                  (ann) => AnnouncementListItem(
                    title: ann.title,
                    preview: ann.preview ?? '',
                    onTap: () {},
                  ),
                ),
              ],
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
