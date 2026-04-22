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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF183764),
              ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF183764)),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF183764)),
            onPressed: () {
              context.read<HomeBloc>().add(HomeRefreshRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: MentorXShimmer(child: MentorXSkeleton(height: 200, width: double.infinity)));
          }

          if (state.status == HomeStatus.failure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load dashboard',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage ?? 'Please check your connection and try again.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    MentorXButton(
                      text: 'Retry',
                      onPressed: () => context.read<HomeBloc>().add(HomeStarted()),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.children.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.people_outline, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No children linked',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Link your child\'s account to start monitoring their progress.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    MentorXButton(
                      text: 'Link a Child',
                      onPressed: () {
                        // Navigate to add child
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(HomeRefreshRequested());
            },
            child: ListView(
              children: [
                const ChildSwitcher(),
                if (state.summary != null && state.selectedChild != null)
                  ParentHeroCard(
                    summary: state.summary!,
                    selectedChildId: state.selectedChild!.id,
                  ),
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: AppSectionHeader(title: 'Recent Activity'),
                ),
                ParentActivityFeed(activities: state.recentActivity),
                
                if (state.announcements.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: AppSectionHeader(title: 'Announcements'),
                  ),
                  ...state.announcements.map((ann) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.campaign_outlined, color: Colors.blue),
                      ),
                      title: Text(
                        ann.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        ann.preview ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Navigate to announcement detail
                      },
                    ),
                  )),
                ],
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
