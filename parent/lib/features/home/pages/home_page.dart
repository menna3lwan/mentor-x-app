import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../widgets/child_switcher.dart';
import '../widgets/parent_hero_card.dart';
import '../widgets/parent_activity_feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeBloc>().add(HomeRefreshRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load dashboard: ${state.errorMessage}'),
                  ElevatedButton(
                    onPressed: () => context.read<HomeBloc>().add(HomeStarted()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.children.isEmpty) {
            return const Center(child: Text('No children linked to this account.'));
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ParentActivityFeed(activities: state.recentActivity),
                
                if (state.announcements.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Announcements',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ...state.announcements.map((ann) => ListTile(
                    title: Text(ann.title),
                    subtitle: Text(ann.preview ?? ''),
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
